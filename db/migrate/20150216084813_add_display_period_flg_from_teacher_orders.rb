class AddDisplayPeriodFlgFromTeacherOrders < ActiveRecord::Migration
  def change
    add_column :teacher_orders, :display_period_flg, :boolean, nil: false, default: true
  end
end
