class CreateCompanyPlans < ActiveRecord::Migration
  def up
    create_table :company_contract_plans do |t|
      t.date :duedate, null:false
      t.text :reason
      t.text :memo
      t.references :company, index: true
      t.timestamps
    end
    create_table :company_payment_plans do |t|
      t.date :duedate, null:false
      t.text :reason
      t.text :memo
      t.references :company, index: true
      t.timestamps
    end

    companies = Company.all
    companies.each do |c|
      if c.read_attribute(:contract_plan).present?
        p c.read_attribute(:contract_plan)
        CompanyContractPlan.create!(duedate: c.read_attribute(:contract_plan), company_id: c.id)
      end
      if c.read_attribute(:payment_plan).present?
        p c.read_attribute(:payment_plan)
        CompanyPaymentPlan.create!(duedate: c.read_attribute(:payment_plan), company_id: c.id)
      end
    end
  end

  def down
    drop_table :company_contract_plans
    drop_table :company_payment_plans
  end
end
