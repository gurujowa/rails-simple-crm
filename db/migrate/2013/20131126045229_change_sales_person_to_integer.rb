class ChangeSalesPersonToInteger < ActiveRecord::Migration
  def up
    user = User.create!([{:id => 8},{:name => "その他"}])
    companies = Company.all
    companies.each do |c|
      if c.sales_person.blank?
        c.update_attribute(:sales_person, 8)
      end
    end
    change_column :companies, :sales_person, :integer, null: false
    remove_column :companies, :bill
    remove_column :companies, :payment_plan
    remove_column :companies, :contract_plan
    remove_column :companies, :proposed_plan
    remove_column :companies, :lead
  end

  def down
    user = User.find(8)
    user.destroy
    change_column :companies, :sales_person, :string
    add_column :companies, :bill, :integer
    add_column :companies, :payment_plan, :date
    add_column :companies, :contract_plan, :date
    add_column :companies, :proposed_plan, :date
    add_column :companies, :lead, :string
  end
end
