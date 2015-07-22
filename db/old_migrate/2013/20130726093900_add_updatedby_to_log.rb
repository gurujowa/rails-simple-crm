class AddUpdatedbyToLog < ActiveRecord::Migration
  def change
    add_column :logs, :created_by, :string
  end
end
