class LeadCommentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    lead_comment = LeadComment.find(params[:id])
    lead = lead_comment.lead
    if lead_comment.destroy
      redirect_to lead_url(lead), notice: 'コメントが正しく削除されました。'
    else
      redirect_to lead_url(lead), notice: 'コメント削除に失敗しました'
    end
  end

  def create
    lead_comment = LeadComment.new(lead_comment_params)
    if params[:joseikin].present?
      lead_comment.category = :joseikin
    elsif params[:jimu].present?
      lead_comment.category = :jimu
    end

    lead_comment.user = current_user
    if lead_comment.save
      redirect_to lead_url(lead_comment.lead), notice: 'コメントが正しく追加されました。'
    else
      redirect_to lead_url(lead_comment.lead), notice: 'コメント追加に失敗しました'
    end
  end

  def update
    begin
      lead_comment = LeadComment.find(params[:pk])
      lead_comment.memo = params[:value]

      if lead_comment.save
        render nothing: true, status: 200
      else
        render text: lead_interview.errors.full_messages, status: 400
      end
    rescue => ex
        render text: ex.message, status: 400
    end
  end


    def lead_comment_params
      params.require(:lead_comment).permit(:id,:memo, :user, :lead_id)
    end
end
