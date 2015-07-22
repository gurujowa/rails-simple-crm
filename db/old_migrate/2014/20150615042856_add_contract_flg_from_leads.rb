class AddContractFlgFromLeads < ActiveRecord::Migration
  def change
    add_column :leads, :contract_flg, :boolean, null: false, default: false
  end
end
