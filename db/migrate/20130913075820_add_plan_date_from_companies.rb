class AddPlanDateFromCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :payment_plan, :date
    add_column :companies, :appoint_plan, :date
    add_column :companies, :contract_plan, :date
    add_column :companies, :proposed_plan, :date
  end
end
