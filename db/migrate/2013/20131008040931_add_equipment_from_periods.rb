class AddEquipmentFromPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :equipment_flg, :boolean, null: false, default: false
  end
end
