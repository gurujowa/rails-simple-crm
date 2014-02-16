class TranslateSalesPerson < ActiveRecord::Migration
  def up
    companies = Company.all
    companies.each do |c|
      Nego.create!(name: "新規顧客向け商談", user_id: c.read_attribute(:sales_person), stage: c.status_id, company_id: c.id)
    end
    remove_column :companies, :sales_person

  end

  def down
    Nego.delete_all
    add_column :companies, :sales_person, :integer
  end
end
