class AddMarkFlgFromLeads < ActiveRecord::Migration
  def change
    add_column :leads, :mark_flg, :boolean
    add_column :leads, :nego_flg, :boolean
  end
end
