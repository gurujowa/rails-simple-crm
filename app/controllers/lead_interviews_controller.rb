class LeadInterviewsController < ApplicationController

  def update
    begin
      lead = Lead.find(params[:pk])
      lead_interview = lead.lead_interview
      if lead_interview.blank?
        
      end
      if @lead.update({params[:name] => params[:value]})
        render nothing: true, status: 200
      else
        render text: @lead.errors.full_messages, status: 400
      end
    rescue => ex
        render text: ex.message, status: 400
    end
  end
  
end
