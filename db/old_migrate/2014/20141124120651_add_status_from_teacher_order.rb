class AddStatusFromTeacherOrder < ActiveRecord::Migration
  def change
    add_column :teacher_orders, :status, :string, null: false, default: "draft"
    TeacherOrder.update_all status: "active"
  end
end
