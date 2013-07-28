class CompaniesController < ApplicationController
  before_action :check_user
  def index
    @company = Company.new
  end

  def search
    begin
      @datas = Company.paginate(:page => params[:page],:order => 'created_at desc', :per_page => 10)
      session[:last_search_url] = params[:company]
      
      @datatables = CompaniesDatatable.new(view_context)
    rescue => e
      logger.fatal "Model Error from company/search  ||" + e.message
      render :text => e
    end
  end
  
  def new
    @company = Company.new
  end


  def create
    @company = Company.new(company_params)
    @company.created_by = session[:current_user].name

      if @company.save
        @log = Log.new(:company_id => @company.id, :status_id => @company.status_id)
        @log.save!
        flash[:notice] = @company.client_name + 'を追加しました。'
        redirect_to :action => "new" 
      else
        render action: 'new'
      end
  end

  
  def edit
    @company = Company.find(params[:id])
    @company.contact.build
  end
  

  def update
    @company = Company.find(params[:id])
    @company.assign_attributes(company_params)
    @company.updated_by = session[:current_user].name
    
    if @company.save
      @log = Log.new(:company_id => @company.id, :status_id => @company.status_id)
      @log.save!
      flash[:notice] = '会社情報が変更されました。'
      redirect_to :action=> 'search', :company => session[:last_search_url]
    else
      render "edit"
    end
  end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def check_user
      if session[:current_user] == nil
        redirect_to :controller => "users", :action=>"current"
      end
    end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
      params.require(:company).permit(:client_name, :client_person, :category, :tel, :fax, :mail, :status_id, :rank, :zipcode, :prefecture,
      :city, :address, :building, :sales_person,:approach_day,  :lead,:bill, contact_attributes: [:id, :memo])
  end
end
