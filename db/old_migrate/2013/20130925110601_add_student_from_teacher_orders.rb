class AddStudentFromTeacherOrders < ActiveRecord::Migration
  def change
    add_column :teacher_orders, :students, :integer
    add_column :teacher_orders, :description, :string
  end
end
