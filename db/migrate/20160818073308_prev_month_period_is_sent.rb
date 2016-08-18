class PrevMonthPeriodIsSent < ActiveRecord::Migration
  def up
    periods = Period.where("day < ?", Time.current.beginning_of_month)
    periods.each do |p|
      PeriodTask.create!(task_type: 4 , checked: true, period_id: p.id)
    end
  end

  def down
    PeriodTask.destroy_all(task_type: 4)
  end
end
