class LeadHistoriesController < ApplicationController
  before_action :set_lead_history, only: [:show, :edit, :update, :destroy]


  # POST /leads
  def create
    @lead_history = LeadHistory.new(lead_history_params)
    @lead_history.user = current_user

    if @lead_history.save
      redirect_to stored_path_for, notice: '顧客対応履歴を作成しました'
    else
      @lead = @lead_history.lead
      @new_lead_history = @lead_history

      @status_ing = LeadHistoryStatus.where(progress: "ing")
      @status_done = LeadHistoryStatus.where(progress: "done")
      @status_forbidden = LeadHistoryStatus.where(progress: "forbidden")
      render template: "leads/show"
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      redirect_to leads_url, notice: '見込み客の更新が完了しました'
    else
      render action: 'edit'
    end
  end

  def lead_show_url lead_id
    return {controller: "leads", action: 'show', id: lead_id}
  end

  # DELETE /leads/1
  def destroy
    @lead_history.destroy
    redirect_to leads_url, notice: 'Lead was successfully destroyed.'
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
      params.require(:lead_history).permit(:approach_day, :next_approach_day, :lead_history_status_id, :memo, :lead_id, :user_id)
    end
end
