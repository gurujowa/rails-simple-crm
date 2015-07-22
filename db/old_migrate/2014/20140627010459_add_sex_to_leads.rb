class AddSexToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :sex, :string
  end
end
