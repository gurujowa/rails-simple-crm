class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy, :add_flg, :contract, :update_tasks]
  after_action :store_location, only: [:index, :search, :mylist, :approach]
  before_action :set_tag, only: [:index,:show, :edit, :update, :create, :new]
  before_action :authenticate_user!

  # GET /leads
  def index
      pq = params[:q]
      leads = Lead.group(:name)
      leads = set_between_dates(leads)

      if params[:status_any].present?
        pq.store(:lead_histories_lead_history_status_id_in,[9,10,11,1,2,3,4,5,6,7,8,16])
        @status_any_checked = true
      else
        @status_any_checked = false
      end

      if params[:mark_flg_present].present?
        pq.store(:mark_flg_true,"t")
        @mark_flg_checked = true
      else
        @mark_flg_checked = false
      end

      if params[:nego_flg_present].present?
        pq.store(:nego_flg_true,"t")
        @nego_flg_checked = true
      else
        @nego_flg_checked = false
      end

      if params[:contract_flg_present].present?
        pq.store(:contract_flg_true,"t")
        @contract_flg_checked = true
      else
        @contract_flg_checked = false
      end

      if params[:status_shipped].present?
        pq.store(:lead_histories_shipped_at_present,1)
        @status_shipped_checked = true
      else
        @status_shipped_checked = false
      end

      if params[:tag_name].present?
        leads = leads.tagged_with(params[:tag_name])
        @tag_name = params[:tag_name]
      end

      #rails4.2になって、orderを設定している場合にjoinしてくれない問題の対応
      if params[:q].present? && params[:q][:s].present?
        leads = leads.joins(:lead_histories)
      end

      @q = leads.search(pq)
      @leads = @q.result.includes(:lead_histories).paginate(page: params[:page],per_page: 100)

      respond_to do |format|
        format.html
        format.csv { send_csv @q.result.includes(:lead_histories).paginate(page: 1,per_page: 30000).to_csv }
      end
  end

  def add_tag
  end

  def add_tag_finish
    tag_name = params[:tag_name]
    tag_list = params[:ids]
    Lead.transaction do
      tag_list.each_line do |id|
        lead = Lead.find(id)
        lead.tag_list.add(tag_name)
        lead.save!
      end
    end
    redirect_to leads_url, notice: '正しくタグがつきました'
  end

  def mylist
      @q = Lead.group(:name).search(params[:q])
      @leads =@q.result.includes(:lead_histories).where(user_id: current_user.id)
      @leads = set_between_dates(@leads)
  end

  def reject_list
    leads = Lead.where(dm_flg: true)
    mark_leads = Lead.where(mark_flg: true)
    nego_leads = Lead.where(nego_flg: true)
    contract_leads = Lead.where(contract_flg: true)
    csvs = CSV.generate do |csv|
      csv << ["会社名","TEL", "FAX"]
      leads.each do |l|
        csv << [l.name, l.tel, l.fax]
      end
      mark_leads.each do |l|
        csv << [l.name, l.tel, l.fax]
      end
      nego_leads.each do |l|
        csv << [l.name, l.tel, l.fax]
      end
      contract_leads.each do |l|
        csv << [l.name, l.tel, l.fax]
      end
    end
    respond_to do |format|
      format.csv { send_csv csvs }
    end

  end

  def address
    leads = Lead.where(id: params[:leads].values)
    csvs = CSV.generate do |csv|
      csv << ["会社名","郵便番号","住所1","ビル名", "担当者名"]
      leads.each do |l|
        csv << [l.name, l.zipcode, l.full_address(false), l.building, l.person_name]
      end
    end

    respond_to do |format|
      format.csv { send_csv csvs }
    end
  end

  def name
    @leads = Lead.where("name like :search", search: "%#{params[:q]}%")
  end

  def find
    @lead = Lead.find(params[:id])
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
    sex_list
    gon.pk = @lead.id

  end

  # GET /leads/new
  def new
    @lead = Lead.new
    @lead.lead_interview = LeadInterview.new
  end

  def set_tag
    gon.tag_list = Lead.tags_on(:tags).map {|i| i.name}
    @tag_list = gon.tag_list
  end

  # GET /leads/1/edit
  def edit
    @tag_name = @lead.tags
    if @lead.lead_interview.blank?
      @lead.lead_interview = LeadInterview.new
    end
  end

  # POST /leads
  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to lead_url(@lead), notice: 'Lead was successfully created.'
    else
      render action: 'new'
    end
  end

  def up_column
    begin
      @lead = Lead.find(params[:pk])
      if @lead.update({params[:name] => params[:value]})
        render nothing: true, status: 200
      else
        render text: @lead.errors.full_messages, status: 400
      end
    rescue => ex
        render text: ex.message, status: 400
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      redirect_to lead_url(@lead), notice: '正しく編集されました'
    else
      if params[:after_show].present?
        @lead.update!(lead_params)
      else
        render action: 'edit'
      end
    end
  end

  def update_tasks
    if @lead.update(lead_params)
      @noty_type = "success"
      @noty_text = "助成金・タスクの登録更新が完了しました。"
      @lead.lead_subsities.each do |ls|
        unless LeadTask.exists?(lead_subsity_id: ls.id)
          @reflesh = true
          @noty_type = "information"
          @noty_text += "  新しい自動タスクが入力されました。３秒後に再更新します。"
          ls.task_list.each do |tasks|
            tasks.save!
          end
        end
      end
    else
      @noty_type = "warning"
      @noty_text = @lead.errors.full_messages
    end
  end

  # DELETE /leads/1
  def destroy
    @lead.destroy
    redirect_to leads_url, notice: 'Lead was successfully destroyed.'
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    session[:previous_url] = request.fullpath 
    session[:last_request_time] = Time.now.utc.to_i
  end

  def add_flg
    flg = @lead.read_attribute params[:type]
    type = params[:type]
    if flg == true
      message = "リストから削除しました"
      clas = %Q{$('#btn-lead-add-#{type}').removeClass("active")} 
    else
      message = "リストに追加しました"
      clas = %Q{$('#btn-lead-add-#{type}').addClass("active")} 
    end

    if @lead.update_attributes({type => !flg})
      render_noty :success, message, clas
    else
      render_noty :error, @to.errors.full_messages
    end
  end
  
  def tasks
    lead_subsities = LeadSubsity.all
    @tasks = []
    lead_subsities.each do |s|
      @tasks += s.tasks
    end
  end

  def contract
    contract_flg = params[:flg]
    @lead.update_attributes!({contract_flg: contract_flg})
    redirect_to :action=> 'show', :id => params[:id], notice: '契約設定が完了しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    def sex_list
      sex = Lead.sex.options
      result = []
      sex.each do |s|
        result.append({value: s[1], text: s[0]})
      end
      gon.sex_list = result.to_json
    end


    def set_between_dates(leads)
      leads = leads.between_last_approach(params[:last_approach_gt], params[:last_approach_lt])
      leads = leads.between_next_approach(params[:next_approach_gt], params[:next_approach_lt])
      @last_approach_gt = params[:last_approach_gt]
      @last_approach_lt = params[:last_approach_lt]
      @next_approach_gt = params[:next_approach_gt]
      @next_approach_lt = params[:next_approach_lt]
      leads
    end


    # Only allow a trusted parameter "white list" through.
    def lead_params
      params.require(:lead).permit(:corporation_name,{:tag_list => []}, :tag_list, :sex, :campaign, :campaign_detail,:city,:name, :tel, :fax, :email, :person_name, :person_kana, :person_post, :url, :zipcode, :prefecture, :street, :building, :memo, :user_id, :star,
      lead_interview_attributes: [:id, :regular_staff, :nonregular_staff, :solvency, :time],
      lead_subsities_attributes:[:id, :name, :subsity_id, :start, :end,:memo,:_destroy],
      lead_tasks_attributes:[:id, :name, :lead_id, :lead_subsity_id, :due_date, :complete_date, :memo, :_destroy],
                                  )
    end
end
