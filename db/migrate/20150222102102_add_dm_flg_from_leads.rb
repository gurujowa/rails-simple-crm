class AddDmFlgFromLeads < ActiveRecord::Migration
  def change
    add_column :leads, :dm_flg, :boolean, nil: false, default: false
  end
end
