class AddPublifhedFromBillingPlans < ActiveRecord::Migration
  def change
    add_column :billing_plans, :publish_date, :date

    remove_column :billing_plan_lines, :due_date, :date
    remove_column :billing_plan_lines, :unit_price, :integer
    remove_column :billing_plan_lines, :quantity, :integer
    add_column :billing_plan_lines, :price, :integer

  end
end
