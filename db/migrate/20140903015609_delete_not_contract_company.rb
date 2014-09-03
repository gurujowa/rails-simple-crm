class DeleteNotContractCompany < ActiveRecord::Migration
  def change
    cs = Company.where.not( active_st: ["contract"])
    cs.destroy_all

    remove_column :companies, :client_person
    remove_column :companies, :approach_day
    remove_column :companies, :chance
    remove_column :companies, :appoint_plan
    remove_column :companies, :latitude
    remove_column :companies, :longitude
    remove_column :companies, :nego_id

    drop_table :company_contract_plans
    drop_table :company_payment_plans
    drop_table :company_proposed_plans
    drop_table :task_types
    drop_table :tasks
    drop_table :bill_lines
    drop_table :bills
    drop_table :statuses
    drop_table :negos

    es = Estimate.where(client_type: "company")
    es.each do |e|
      company = Company.find_by_id(e.client_id)
      if company.blank?
        e.destroy
      end
    end

  end
end
