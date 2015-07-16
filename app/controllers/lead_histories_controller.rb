class LeadHistoriesController < ApplicationController
  before_action :set_lead_history, only: [:show, :edit, :update, :destroy, :sent]
  before_action :authenticate_user!

  def index
    @q = LeadHistory.search(params[:q])
    @lead_histories = @q.result.paginate(page: params[:page],per_page: 100)

    respond_to do |format|
      format.html
      format.csv { send_csv LeadHistory.all.to_csv }
    end
  end

  def approach
    @next_approach_gt = params[:next_approach_gt].present? ? DateTime.parse(params[:next_approach_gt]) : DateTime.now.prev_year
    @next_approach_lt = params[:next_approach_lt].present? ? DateTime.parse(params[:next_approach_lt]) : DateTime.now.next_year
    @lead_histories = LeadHistory.where(next_approach_day: @next_approach_gt...@next_approach_lt)
  end

  # POST /leads
  def create
    @lead_history = LeadHistory.new(lead_history_params)
    @lead_history.user = current_user

    if @lead_history.save
      redirect_to lead_url @lead_history.lead, notice:'顧客対応履歴を作成しました'
    else
      @lead = @lead_history.lead
      @new_lead_history = @lead_history

      @status_ing = LeadHistoryStatus.where(progress: "ing")
      @status_done = LeadHistoryStatus.where(progress: "done")
      @status_forbidden = LeadHistoryStatus.where(progress: "forbidden")
      render template: "leads/show"
    end
  end

  def shipped
    @lead_histories = LeadHistory.sent_list
  end

  
  def zip
    @lead_histories = LeadHistory.status_zip
  end

  def sent
    @lead_history.send_pamph
    lead = @lead_history.lead
    lead.tag_list.add("初回資料郵送済")
    lead.save
    redirect_to action: :zip, notice: '発送済みにしました'
  end

  def total_all
    @lead_histories = LeadHistory.where('approach_day > ?', Date.new(2013,8,1))
  end

  def total
    raise "user_idは必須です" if params[:user_id].blank?
    if params[:date].present?
      @date = Date.new(params[:date][:year].to_i,params[:date][:month].to_i, 1)
    else
      @date = Date.today
    end

    from = @date.beginning_of_month
    to = @date.end_of_month + 1.day

    @lead_histories = LeadHistory.where(user_id: params[:user_id]).where(approach_day: from...to)
  end


  def edit
  end

  def update
    if @lead_history.update(lead_history_params)
      redirect_to lead_url @lead_history.lead, notice: '見込み客の更新が完了しました'
    else
      render action: 'edit'
    end
  end

  def remove_attachment
    @at= LeadHistoryAttachment.find(params[:id])
    @at.remove_attachment!
    if @at.save
      @at.destroy!
      redirect_to lead_url(@at.lead_history.lead), notice: '添付ファイルの削除に成功しました。'
    else
      redirect_to lead_url(@at.lead_history.lead), error: '添付ファイルの削除が出来ませんでした'
    end
  end


  # DELETE /leads/1
  def destroy
    lead = @lead_history.lead
    @lead_history.destroy
    redirect_to lead_url(lead), notice: 'Lead was successfully destroyed.'
  end

  def stored_path_for
    session["previous_url"] || leads_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead_history
      @lead_history = LeadHistory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lead_history_params
      params.require(:lead_history).permit(
        :approach_day, :next_approach_day, :lead_history_status_id, :memo, :lead_id, :user_id,
     lead_history_attachments_attributes: [:id, :attachment]
        
      )
    end
end
