class CompaniesController < ApplicationController
  before_action :check_user
  def index
    @company = Company.new
    @statuses = Status.find_all_by_active(true)
  end

  def search
    begin
      @datas = Company.paginate(:page => params[:page],:order => 'created_at desc', :per_page => 10)
      session[:last_search_url] = params[:company]
      
      @datatables = CompaniesDatatable.new(view_context)
      @company = Company.new
      @statuses = Status.find_all_by_active(true)
      @company.assign_attributes(company_params)
    rescue => e
      logger.fatal "Model Error from company/search  ||" + e.message
      render :text => e
    end
  end
  
 def pdf
    @companies = Company.find(checkbox_append(params))
    if (params["junban"].present?)
      params["junban"].to_i.times{ @companies.unshift(Company.new)}
    end
    if (@companies.length > 21)
      flash[:error] = '２２個以上を印刷することはできません'
      redirect_to :action=> 'search', :company => session[:last_search_url]
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
    @company.contact.build
  end


  def create
    @company = Company.new(company_params)
    @company.created_by = session[:current_user].id

      if @company.save
        @log = Log.new(:company_id => @company.id, :status_id => @company.status_id, :created_by => session[:current_user].name)
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
    @company.updated_by = session[:current_user].id
    
    if @company.save
      @log = Log.new(:company_id => @company.id, :status_id => @company.status_id,  :created_by => session[:current_user].name)
      @log.save!
      flash[:notice] = '会社情報が変更されました。'
      redirect_to :action=> 'search', :company => session[:last_search_url]
    else
      render "edit"
    end
  end
  
  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = '会社情報を削除しました'
    redirect_to :action=> 'search', :company => session[:last_search_url]
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
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def check_user
      if session[:current_user] == nil
        redirect_to :controller => "users", :action=>"current"
      end
    end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
      params.require(:company).permit(:client_name, :client_person, :category, :tel, :fax, :mail, :status_id,  :zipcode, :prefecture,
      :city, :address, :building, :sales_person,:approach_day, :chance,  :lead,  :created_at, :created_by, :updated_at, :updated_by,
      :bill, contact_attributes: [:id, :memo])
  end
end
