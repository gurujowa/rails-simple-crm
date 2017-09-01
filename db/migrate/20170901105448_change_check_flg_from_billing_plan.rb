class ChangeCheckFlgFromBillingPlan < ActiveRecord::Migration[5.0]

  def change
    remove_column :billing_plans, :check_flg, :boolean
    add_column :billing_plans, :check_flg, :boolean, null: false, default: false
  end
end
