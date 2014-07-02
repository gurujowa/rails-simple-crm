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

  def analysis
      id = params[:id]
      id = current_user.id if id.blank?
      his = LeadHistory.where("approach_day > ?", DateTime.new.beginning_of_month)

#      h = LeadHistory.where(user_id: 8).tel_report.to_a.map{|l| l[0]}
#      t = LeadHistory.where(user_id: 1).tel_report.to_a.map{|l| l[1].to_i}
#      f = LeadHistory.where(user_id: 2).tel_report.to_a.map{|l| l[1].to_i}
#      a = LeadHistory.where(user_id: 3).tel_report.to_a.map{|l| l[1].to_i}
      calculation = LeadHistory.where(user_id: [13,2,1]).calculate(:count,:all, group: [:user_id,:approach_day])
      table = PivotTable.new
      table.set_rows calculation
      @table = table


#      l = LeadHistory.get_stat(:user_count,:user_id => 1) 
#      table = LeadHistory.exclude_initial.report_table(:all, only: %w[id user_id approach_day], group: "user_id, approach_day")
#      g= Grouping(table, by: "approach_day")

#      rubygems_versions = Table(%w[user_id count])  

#      g.each do |name,group|
#        Grouping(group, :by => "rubygems_version").each do |vname,group|
#          rubygems_versions << { "platform"         => name, 
#                                 "rubygems_version" => vname,
#                                 "count"            => group.length }
#        end
#      end
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

  def lead_show_url lead_id
    return {controller: "leads", action: 'show', id: lead_id}
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
      params.require(:lead_history).permit(:approach_day, :next_approach_day, :lead_history_status_id, :memo, :lead_id, :user_id)
    end
end
