class AddIndustryFromCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :industry_id, :integer,{:null => false, :default => 1}
  end
end
