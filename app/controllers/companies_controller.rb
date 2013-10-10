class CompaniesController < ApplicationController
  before_action :check_user

  def index
      @not_complite = Task.where.not(progress_id: [TaskProgress.getId(:finish),TaskProgress.getId(:canceled)]).
      order("duedate asc").all
      
      @not_task = Company.connection.select_all('
      SELECT companies.id,companies.client_name,statuses.name as status, companies.sales_person as sales_person, strftime("%Y-%m-%d",companies.updated_at) as up_at
      FROM companies 
      LEFT JOIN tasks ON tasks.company_id = companies.id
      INNER JOIN statuses ON statuses.id = companies.status_id
      WHERE statuses.rank IN ("B","C","D","E") AND tasks.id Is Null
      GROUP BY companies.client_name, companies.updated_at
      order by up_at ASC;
      ')

      @not_complite_current = Task.where.not(progress_id: [TaskProgress.getId(:finish),TaskProgress.getId(:canceled)]).
      where(assignee: session[:current_user].id).order("duedate asc").all
      
      @not_task_current = Company.connection.select_all('
      SELECT companies.id,companies.client_name,statuses.name as status, strftime("%Y-%m-%d",companies.updated_at) as up_at
      FROM companies 
      LEFT JOIN tasks ON tasks.company_id = companies.id
      INNER JOIN statuses ON statuses.id = companies.status_id
      WHERE statuses.rank IN ("B","C","D","E")
      AND (tasks.id) Is Null 
      AND companies.sales_person = ' + session[:current_user].id.to_s + '
      GROUP BY companies.client_name, companies.updated_at
      order by up_at Asc;
      ')
      
      @uncomplite = Company.connection.select_all('
      SELECT companies.id as comp_id,companies.client_name,statuses.name as status, 
      companies.sales_person as sales_person, 
      strftime("%Y-%m-%d",companies.updated_at) as up_at
      FROM companies 
      INNER JOIN statuses ON statuses.id = companies.status_id
      WHERE statuses.rank IN ("B","C","D","E") 
      AND NOT EXISTS(select id from tasks where tasks.company_id = comp_id and tasks.progress_id in (1,2,3))
      GROUP BY companies.client_name, companies.updated_at
      order by up_at DESC;
      ')
  end

  def client_sheet
    @company = Company.find(params[:id])
    report = Report.new "client_sheet.xls"
    report.cell "A1",@company.client_name + "様"
    report.cell "F3",%Q{担当：#{session[:current_user].name}}
    report.cell "B4",%Q{担当：#{@company.client_person}様}
    report.cell "B5",@company.full_address
    report.cell "E6",@company.tel

    send_file report.write  , :type=>"application/ms-excel", :filename => "client_sheet.xls"

  end

  def name
    @companies = Company.joins(:status).where("client_name like :search", search: "%#{params[:q]}%").where(:statuses => {rank:  ["A".."K"]}).
       order("statuses.rank asc")
  end

  def find
    @company = Company.find(params[:id])
  end
  
  def usershow
    if (!params[:id].present?)
      params[:id] = session[:current_user].id
    end
    @companies = Company.joins(:status).where(sales_person: params[:id] ).where(:statuses => {rank: "B".."H"}).
    order("companies.chance desc, companies.status_id asc, companies.id asc").limit(20)

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
        @company.assign_attributes(company_params)
      end
      @company_params =  @company.attributes.to_hash
      
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
  
  def up_postsend
    @companies = Company.find(checkbox_append(params))
    
    begin
      @companies.each do |c|
        c.status_id = 14
        c.save!
      end
    rescue => e
      logger.fatal "up_postsend error  ||" + e.message
      render :json => {'text' => e.message, 'type' => 'error'}
      return
    end

    render :json => {'text' => 'ステータスの変更が完了しました', 'type' => 'alert'}
    return
  end

  def new
    @company = Company.new
    @company.contact.build(:created_by => session[:current_user].id)
    set_default_form
  end


  def create
    @company = Company.new(company_params)
    @company.created_by = session[:current_user].id
    set_default_form

      if @company.save
        @log = Log.new(:company_id => @company.id, :status_id => @company.status_id, :created_by => session[:current_user].name)
        @log.save!

        if(params[:new_task][:name]).present?
          @new_task = Task.new(new_task_params)
          @new_task.created_by = session[:current_user].id
          @new_task.company_id = @company.id
          @new_task.save!
        end
        flash[:notice] = @company.client_name + 'を追加しました。'
        redirect_to :action => "new" 
      else
        @company.contact.build(:created_by => session[:current_user].id)
        render action: 'new'
      end
  end

  
  def edit
    @company = Company.find(params[:id])
    @company.contact.build(:created_by => session[:current_user].id)
    @course = Course.where(company_id: params[:id])
    set_default_form
  end
  

  def update
    @company = Company.find(params[:id])
    @company.assign_attributes(company_params)
    @company.updated_by = session[:current_user].id
    @course = Course.where(company_id: params[:id])
    set_default_form

    
    if @company.save
      @log = Log.new(:company_id => @company.id, :status_id => @company.status_id,  :created_by => session[:current_user].name)
      @log.save!
      flash[:notice] = '会社情報が変更されました。'
      redirect_to :action=> 'search', :company => session[:last_search_url], :last_rank => session[:last_search_rank]
    else
      @company.contact.build(:created_by => session[:current_user].id)
      render "edit"
    end
  end
  
  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = '会社情報を削除しました'
    redirect_to :action=> 'search', :company => session[:last_search_url], :last_rank => session[:last_search_rank]
  end
  
  private
  def set_default_form()
    @task = Task.new
    @task_types = TaskType.order("tag").all
    @industries = Industry.all

  end
  
  private
  def checkbox_append(params)
    ids = []
    params.each do |p|
      if ( p[0].include?("check") )
        ids.push(p[1])
      end
    end
    return ids
  end
  

  
  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
      params.require(:company).permit(:id, :client_name, :client_person, :category, :tel, :fax, :mail, :status_id,  :zipcode, :prefecture,
      :city, :address, :building,:industry_id, :sales_person,:approach_day, :chance,  :lead,  :created_at, :created_by, :updated_at, :updated_by,
      :bill, :campaign_id, :appoint_plan, :proposed_plan, :contract_plan, :payment_plan, contact_attributes: [:id, :memo, :created_by, :con_type])
  end
  
  private
  def new_task_params
      params.require(:new_task).permit(:name, :duedate, :assignee, :progress_id, :type_id , :note)
  end
end
