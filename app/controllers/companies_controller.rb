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
    gon.tag_list = Company.tags_on(:tags).map {|i| i.name}
  end
  

  def index
    @q = Company.search(params[:q])
    @companies = @q.result.paginate(page: params[:page],per_page: 100)

      if params[:tag_name].present?
        @companies = @companies.tagged_with(params[:tag_name])
        @tag_name = params[:tag_name]
      end


      tl = Company.tags_on(:tags)
      @tag_list = []
      tl.each do |t|
        @tag_list.push([t.name, t.name])
      end

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
      redirect_to :action=> 'index', :company => session[:last_search_url], :last_rank => session[:last_search_rank], notice: '正しく編集されました'
    else
      @company.contacts.build(:created_by => current_user.id)
      if params[:after_show].present?
        @company.update!(company_params)
      else
        render action: 'edit'
      end
    end
  end

  def address
    cs = Company.where(id: params[:companies].values)
    csvs = CSV.generate do |csv|
      csv << ["会社名","郵便番号","住所1","ビル名", "担当者名"]
      cs.each do |l|
        csv << [l.name, l.zipcode, l.full_address(false), l.building, l.client_person]
      end
    end

    respond_to do |format|
      format.csv { send_csv csvs }
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
    params.require(:company).permit(:id, :client_name,  :category, :tel, :fax,  :active_st,  :zipcode, :prefecture, 
      :city,:tag_list, :address, :building, :tel2, :fax2, :prefecture2, :zipcode2, :city2, :address2, :building2, :mail, :industry_id, :regular_staff, :nonregular_staff, :memo, :lead, :created_by,  :updated_by, :campaign_id,
      contacts_attributes: [:id, :memo, :created_by, :con_type],
      clients_attributes: [:id, :last_name, :first_name, :last_kana, :first_kana, :gender, :official_position,  :memo])
  end

end
