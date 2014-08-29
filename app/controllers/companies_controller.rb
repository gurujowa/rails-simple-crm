class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def name
    @companies = Company.where("companies.client_name like :search", search: "%#{params[:q]}%").is_active
  end

  def find
    @company = Company.find(params[:id])
  end

  def show
    @company = Company.find(params[:id])
    @courses = Course.where(company_id: params[:id])
  end
  

  def index
    @q = Company.search(params[:q])
    @companies = @q.result.paginate(page: params[:page],per_page: 100)
    session[:last_search_url] = params[:company]
    session[:last_search_rank] = params[:rank]
    if params[:last_rank].present? then
      params[:rank] = params[:last_rank]
    end
    @company = Company.new
    

    @statuses = Status.order(:rank).find_all_by_active(true)

    respond_to do |format|
      format.html
      format.csv  { 
        send_data @datatables.all.to_csv.tosjis,
               :type => 'text/csv; charset=shift_jis; header=present',
                :disposition => "attachment; filename=companies_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}.csv"
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
      redirect_to :action=> 'index', :company => session[:last_search_url], :last_rank => session[:last_search_rank]
      return 
    end
    respond_to do |format|
      format.html { 
        @checkbox_params = checkbox_append(params)
        render :layout => "pdf.html"
      }
      format.pdf {
        render pdf: "ラベル",
               margin: {top: 0, bottom: 0 , left: 0, right: 0},
               encoding: 'UTF-8',
               layout: 'pdf.html',
               show_as_html: params[:debug].present?
      }
    end
  end
  
  def new
    @company = Company.new
    @company.contacts.build(:created_by => current_user.id)
    @company.clients.build
    @company.negos.build(name: "新規商談")
    @industries = Industry.all
  end


  def create
    @company = Company.new(company_params)
    @company.created_by = current_user.id
    @company.updated_by = current_user.id
    @industries = Industry.all

      if @company.save
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
    @industries = Industry.all
  end
  

  def update
    @company = Company.find(params[:id])
    @company.assign_attributes(company_params)
    @company.updated_by = current_user.id
    @course = Course.where(company_id: params[:id])
    @industries = Industry.all

    if @company.save
      flash[:notice] = '会社情報が変更されました。'
      redirect_to :action=> 'index', :company => session[:last_search_url], :last_rank => session[:last_search_rank]
    else
      @company.contacts.build(:created_by => current_user.id)
      render "edit"
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = '会社情報を削除しました'
    redirect_to :action=> 'index', :company => session[:last_search_url], :last_rank => session[:last_search_rank]
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
      :city, :address, :building, :tel2, :fax2, :prefecture2, :zipcode2, :city2, :address2, :building2, :mail, :industry_id, :regular_staff, :nonregular_staff, :memo, :approach_day,  :lead, :created_by,  :updated_by, :campaign_id,  
      contacts_attributes: [:id, :memo, :created_by, :con_type],
      clients_attributes: [:id, :last_name, :first_name, :last_kana, :first_kana, :gender, :official_position,  :memo],
      negos_attributes: [:id, :name, :status_id, :user_id,  :memo],
                                   )
  end

end
