class CreateCompanyProposedPlans < ActiveRecord::Migration
  def up
    create_table :company_proposed_plans do |t|
      t.date :duedate, null:false
      t.text :reason
      t.text :memo
      t.references :company, index: true

      t.timestamps
    end

    companies = Company.all
    companies.each do |c|
      if c.read_attribute(:proposed_plan).present?
        p c.read_attribute(:proposed_plan)
        CompanyProposedPlan.create!(duedate: c.read_attribute(:proposed_plan),reason:"initial", company_id: c.id)
      end
    end
  end

  def down
    drop_table :company_proposed_plans
  end
end
