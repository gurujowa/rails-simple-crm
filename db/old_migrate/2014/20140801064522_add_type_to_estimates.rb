class AddTypeToEstimates < ActiveRecord::Migration
  def change
    add_column :estimates, :client_type, :string, null: false, default: "company"
    rename_column :estimates, :company_id, :client_id
    drop_table :lead_estimates
  end
end
