class PeriodsController < ApplicationController  
  before_action :authenticate_user!

  def index
    @periods = Period.where("day >= ?",Time.current.prev_month).order("day desc")
  end

  def checklist
    begin
      @period = Period.find(params[:pk])
      PeriodTask.task_types.each do |key,val|
        check_record = @period.period_tasks.find_by(task_type: val)
        flag = params[:value].include?(val.to_s)
        if check_record.present?
          check_record.update_attributes!(checked: flag)
        else
          PeriodTask.create!(task_type: val, checked: flag, period_id: @period.id)
        end
      end
      
      if @period
        render nothing: true, status: 200
      else
        render text: @peirod.errors.full_messages, status: 400
      end
    rescue => ex
        render text: ex.message, status: 400
    end
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
