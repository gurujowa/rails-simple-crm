class ChangeStatusFlagFromBillingPlan < ActiveRecord::Migration
  def change
    add_column :billing_plans, :send_flg, :boolean, null: false, default: false
    remove_column :billing_plans, :status, :string
  end
end
