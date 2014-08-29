class AddDisplayNameFromBillingPlan < ActiveRecord::Migration
  def change
    add_column :billing_plans, :display_name, :string
  end
end
