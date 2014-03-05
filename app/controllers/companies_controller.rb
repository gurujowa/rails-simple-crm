class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
      @not_complite = Task.where.not(progress_id: [TaskProgress.getId(:finish),TaskProgress.getId(:canceled)]).where("duedate <= ?", Date.today).
      order("duedate asc").all
      

      @not_complite_current = Task.where.not(progress_id: [TaskProgress.getId(:finish),TaskProgress.getId(:canceled)]).
      where(assignee: current_user.id).order("duedate asc").all
  end

  def client_sheet
    @company = Company.find(params[:id])
    report = Report.new "client_sheet.xls"
    report.cell "A1",@company.client_name + "様"
    report.cell "F3",%Q{担当：#{current_user.name}}
    report.cell "B4",%Q{担当：#{@company.client_person}様}
    report.cell "B5",@company.full_address
    report.cell "E6",@company.tel

    send_file report.write  , :type=>"application/ms-excel", :filename => "client_sheet.xls"
  end

  def name
    @companies = Company.where("companies.client_name like :search", search: "%#{params[:q]}%").is_active
  end

  def find
    @company = Company.find(params[:id])
  end
  
  def usershow
    if (!params[:id].present?)
      params[:id] = current_user.id
    end
    @negos = Nego.joins(:status,:company).where(user_id: params[:id] ).is_active.
    order("companies.active_st asc, statuses.rank asc, companies.id asc").limit(40)

    respond_to do |format|
      format.html
      format.csv { render text: @companies.to_csv.tosjis }
    end
  end


  def search
    @datas = Company.paginate(:page => params[:page],:order => 'created_at desc', :per_page => 10)
    session[:last_search_url] = params[:company]
    session[:last_search_rank] = params[:rank]
    if params[:last_rank].present? then
      params[:rank] = params[:last_rank]
    end

    @datatables = CompaniesDatatable.new(view_context)
    @company = Company.new
    @statuses = Status.order(:rank).find_all_by_active(true)
    if (params[:company].present?)
      @company.assign_attributes(search_params)
      @active_st = params[:active_st]
    end
    @company_params =  @company.attributes.to_hash

    respond_to do |format|
      format.html
      format.json
      format.csv  { 
        send_data @datatables.all.to_csv.tosjis,
               :type => 'text/csv; charset=shift_jis; header=present',
                :disposition => "attachment; filename=companies_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}.csv"
      }
    end
  end

  def map
    @company = Company.new
    if (params[:company].present?)
      @company.assign_attributes(search_params)
    end

    respond_to do |format|
      format.html
      format.json {
        table = CompaniesDatatable.new(view_context)
        @companies = table.all.where("latitude is not null")
      }
    end
  end

  
 def pdf
    @companies = Company.find(checkbox_append(params))
    if (params["junban"].present?)
      params["junban"].to_i.times{ @companies.unshift(Company.new)}
    end
    if (@companies.length > 21)
      flash[:error] = '２２個以上を印刷することはできません'
      redirect_to :action=> 'search', :company => session[:last_search_url], :last_rank => session[:last_search_rank]
      return 
    end
    respond_to do |format|
      format.html { 
        @format_html_flg = true
        @checkbox_params = checkbox_append(params)
        render :layout => "pdf.html"
      }
      format.pdf {
        @format_html_flg = false
        html = render_to_string(:layout => "pdf.html", :formats => [:html])
        kit = PDFKit.new(html)
        send_data(kit.to_pdf, :filename => "ラベル.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
    end
  end
  
  def new
    @company = Company.new
    @company.contacts.build(:created_by => current_user.id)
    @company.clients.build
    @company.negos.build(name: "新規商談")
    set_default_form
  end


  def create
    @company = Company.new(company_params)
    @company.created_by = current_user.id
    @company.updated_by = current_user.id
    set_default_form

      if @company.save
        if(params[:new_task][:name]).present?
          @new_task = Task.new(new_task_params)
          @new_task.created_by = current_user.id
          @new_task.company_id = @company.id
          @new_task.save!
        end
        flash[:notice] = @company.client_name + 'を追加しました。'
        redirect_to :action => "new" 
      else
        @company.contacts.build(:created_by => current_user.id)
        render action: 'new'
      end
  end

  
  def edit
    @company = Company.find(params[:id])
    @company.contacts.build(:created_by => current_user.id)
    @company.clients.build
    @company.negos.build

    @course = Course.where(company_id: params[:id])
    set_default_form
  end
  

  def update
    @company = Company.find(params[:id])
    @company.assign_attributes(company_params)
    @company.updated_by = current_user.id
    @course = Course.where(company_id: params[:id])
    set_default_form

    if @company.save
      flash[:notice] = '会社情報が変更されました。'
      redirect_to :action=> 'search', :company => session[:last_search_url], :last_rank => session[:last_search_rank]
    else
      @company.contacts.build(:created_by => current_user.id)
      render "edit"
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = '会社情報を削除しました'
    redirect_to :action=> 'search', :company => session[:last_search_url], :last_rank => session[:last_search_rank]
  end
  
  private
  def set_default_form
    @task = Task.new
    @task_types = TaskType.order("tag").all
    @industries = Industry.all
  end

  def checkbox_append(params)
    ids = []
    params.each do |p|
      if ( p[0].include?("check") )
        ids.push(p[1])
      end
    end
    return ids
  end

  def search_params
    params.require(:company).permit!
  end
  
  def company_params
    params.require(:company).permit(:id, :client_name,  :category, :tel, :fax,  :active_st,  :zipcode, :prefecture, :appoint_plan,
      :city, :address, :building, :mail, :industry_id, :regular_staff, :nonregular_staff, :memo, :approach_day,  :lead, :created_by,  :updated_by, :campaign_id,  
      contacts_attributes: [:id, :memo, :created_by, :con_type],
      clients_attributes: [:id, :last_name, :first_name, :last_kana, :first_kana, :gender, :official_position,  :memo],
      negos_attributes: [:id, :name, :status_id, :user_id,  :memo],
                                   )
  end

  def new_task_params
      params.require(:new_task).permit(:name, :duedate, :assignee, :progress_id, :type_id , :note)
  end
end
