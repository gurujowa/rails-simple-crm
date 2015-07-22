class UniqueLeadTel < ActiveRecord::Migration
  def up
    add_index :leads, :tel, :unique => true
  end

  def down
    remove_index :leads, :tel
  end
end
