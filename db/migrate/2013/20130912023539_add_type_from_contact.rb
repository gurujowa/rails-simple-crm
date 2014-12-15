class AddTypeFromContact < ActiveRecord::Migration
  def change
    add_column :contacts, :con_type, :integer
  end
end
