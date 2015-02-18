class AddTeacherOrderPeriodType < ActiveRecord::Migration
  def change
    remove_column :teacher_orders, :display_period_flg, :boolean, nil: false, default: true
    add_column :teacher_orders, :period_type, :string, nil: false, default: "auto"

    create_table :teacher_order_periods do |t|
      t.date     "day",                           null: false
      t.time     "start_time",                    null: false
      t.time     "end_time",                      null: false
      t.time     "break_start"
      t.time     "break_end"
      t.text "memo"
      t.integer "teacher_order_id", nil: false

      t.timestamps
    end
  end
end
