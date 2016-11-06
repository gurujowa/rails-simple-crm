class AddStudentsFromPeriods < ActiveRecord::Migration[5.0]
  def change
    add_column :periods, :students, :integer
    add_column :periods, :theme, :string
  end
end
