class AddAirtableIdFromLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :leads, :airtable_id, :string
  end
end
