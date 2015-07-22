class AddFlagFromTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :orientation_flg, :boolean
    add_column :teachers, :profile_flg, :boolean
    add_column :teachers, :photo_flg, :boolean
    add_column :teachers, :regist_flg, :boolean
    add_column :teachers, :contract_flg, :boolean
    add_column :teachers, :bill, :integer
    add_column :teachers, :tel, :string
    add_column :teachers, :email, :string
  end
end
