class AddCheckFlgFromBillingPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :billing_plans, :check_flg, :boolean
  end
end
