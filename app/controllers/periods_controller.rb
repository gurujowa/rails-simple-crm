class PeriodsController < ApplicationController  
  before_action :authenticate_user!

  def index
    @periods = Period.where("day >= ?",Time.current.prev_month).order("day desc")
  end

  def update
    begin
      @period = Period.find(params[:pk])
      if @period.update({params[:name] => params[:value]})
        render nothing: true, status: 200
      else
        render text: @peirod.errors.full_messages, status: 400
      end
    rescue => ex
        render text: ex.message, status: 400
    end
  end

end
