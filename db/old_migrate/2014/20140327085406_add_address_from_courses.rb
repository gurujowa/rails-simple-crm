class AddAddressFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :address, :string
    add_column :courses, :station, :string
    add_column :courses, :responsible, :string
    add_column :courses, :tel, :string
  end
end
