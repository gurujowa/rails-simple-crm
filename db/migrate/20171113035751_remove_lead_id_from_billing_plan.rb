class RemoveLeadIdFromBillingPlan < ActiveRecord::Migration[5.0]
  def change
    remove_column :billing_plans, :lead_id, :integer, null: false, default: true
  end
end
