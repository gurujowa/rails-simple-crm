class CreatePeriodCheckLists < ActiveRecord::Migration
  def up
    create_table :period_tasks do |t|
      t.references :period, index: true, foreign_key: true, null: false
      t.integer :task_type, null: false
      t.boolean :checked, null: false, default: false

      t.timestamps null: false
    end
    prev_periods = Period.where("day < ?", Time.current.beginning_of_month)
    prev_periods.each do |p|
      PeriodTask.create!(period_id: p.id, task_type: 3, checked: true)
    end

    next_periods = Period.where("day > ?", Time.current.beginning_of_month)
    next_periods.each do |p|
      if p.resume_status == :notstart
      elsif p.resume_status == :unnecessary
        PeriodTask.create!(period_id: p.id, task_type: 3, checked: true)
      elsif p.resume_status == :complete
        PeriodTask.create!(period_id: p.id, task_type: 0, checked: true)
        PeriodTask.create!(period_id: p.id, task_type: 1, checked: true)
        PeriodTask.create!(period_id: p.id, task_type: 2, checked: true)
      else
        raise "oh no"
      end
    end
  end

  def down
    drop_table :period_tasks
  end
end
