class AddDisplayNameFromEstimates < ActiveRecord::Migration
  def change
    add_column :estimates, :display_name, :string
  end
end
