class AddOrderAvailableFromPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :order_available, :boolean, null: false, default: false
  end
end
