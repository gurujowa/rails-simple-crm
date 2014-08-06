class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  after_action :store_location, only: [:index, :search, :mylist, :approach]
  before_action :authenticate_user!

  # GET /leads
  def index
      @q = Lead.group(:name).search(params[:q])
      @leads = @q.result.includes(:lead_histories).paginate(page: params[:page],per_page: 100)
  end

  def mylist
      @q = Lead.group(:name).search(params[:q])
      @leads =@q.result.includes(:lead_histories).where(user_id: current_user.id)
  end

  def tag
      @q = Lead.group(:name).search(params[:q])
      @leads =@q.result.includes(:lead_histories).tagged_with(params[:id])
  end

  def approach
      @q = Lead.group(:name).search(params[:q])
      inner = "(SELECT id AS last_his_id , lead_id AS last_id, MAX(approach_day) AS max_approach_day FROM lead_histories  WHERE approach_day is not null GROUP BY lead_id) AS last_his"
      result = LeadHistory.find_by_sql(["SELECT his.id, last_his.max_approach_day, his.next_approach_day , his.lead_id
                                       FROM lead_histories AS his INNER JOIN #{inner} ON his.id = last_his.last_his_id where next_approach_day is not null AND his.user_id = :user_id  order by next_approach_day asc",{ user_id: params[:id]}])

      @lead_histories = result
  end

  def name
    @leads = Lead.where("name like :search", search: "%#{params[:q]}%")
  end

  def find
    @leads = Lead.find(params[:id])
  end

  def add_mylist
    @lead = Lead.find(params[:id])

    if @lead.user_id.blank?
      if @lead.update_attributes({user_id: current_user.id})
        render_noty :success, "マイリストに追加しました", %Q{$('#btn-lead-add-mylist').addClass("active")} 
      else
        render_noty :error, @to.errors.full_messages
      end    
    else
      if @lead.update_attributes({user_id: nil})
        render_noty :success, "マイリストを解除しました", %Q{$('#btn-lead-add-mylist').removeClass("active")} 
      else
        render_noty :error, @to.errors.full_messages
      end    
    end
  end

  def search
    index
    render :index
  end

  # GET /leads/1
  def show
    @new_lead_history = LeadHistory.new
    @new_lead_history.lead_id = @lead.id
    @new_lead_history.approach_day = DateTime.now()

    @status_ing = LeadHistoryStatus.where(progress: "ing")
    @status_done = LeadHistoryStatus.where(progress: "done")
    @status_forbidden = LeadHistoryStatus.where(progress: "forbidden")
  end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads
  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to leads_url, notice: 'Lead was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      if params[:after_show].present?
        redirect_to lead_url(@lead), notice: '正しく編集されました'
      else
        redirect_to after_update_path_for, notice: 'Lead was successfully updated.'
      end
    else
      render action: 'edit'
    end
  end

  # DELETE /leads/1
  def destroy
    @lead.destroy
    redirect_to leads_url, notice: 'Lead was successfully destroyed.'
  end

  def after_update_path_for
    session[:previous_url] || leads_url
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    session[:previous_url] = request.fullpath 
    session[:last_request_time] = Time.now.utc.to_i
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lead_params
      params.require(:lead).permit(:corporation_name,{:tag_list => []}, :tag_list, :sex, :campaign, :campaign_detail,:city,:name, :tel, :fax, :email, :person_name, :person_kana, :person_post, :url, :zipcode, :prefecture, :street, :building, :memo, :user_id, :star)
    end
end
