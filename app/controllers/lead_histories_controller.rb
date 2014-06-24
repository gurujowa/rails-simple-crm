class LeadHistoriesController < ApplicationController
  before_action :set_lead_history, only: [:show, :edit, :update, :destroy]


  # POST /leads
  def create
    @lead_history = LeadHistory.new(lead_history_params)
    @lead_history.user = current_user

    if @lead_history.save
      redirect_to lead_show_url(@lead_history.lead_id), notice: '顧客対応履歴を作成しました'
    else
      render controller: "leads", action: 'show', id: @lead_history.lead_id 
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      redirect_to leads_url, notice: 'Lead was successfully updated.'
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead_history
      @lead_history = LeadHistory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lead_history_params
      params.require(:lead_history).permit(:approach_day, :next_approach_day, :status, :memo, :lead_id, :user_id)
    end
end
