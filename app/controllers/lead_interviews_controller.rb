class LeadInterviewsController < ApplicationController

  def update
    begin
      lead = Lead.find(params[:id])
      lead_interview = lead.lead_interview
      if lead_interview.blank?
        lead_interview = lead.lead_interview.new
      end
      if lead_interview.update({params[:name] => params[:value]})
        render nothing: true, status: 200
      else
        render text: lead_interview.errors.full_messages, status: 400
      end
    rescue => ex
        render text: ex.message, status: 400
    end
  end
  
end
