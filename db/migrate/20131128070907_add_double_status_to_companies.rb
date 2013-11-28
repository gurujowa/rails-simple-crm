class AddDoubleStatusToCompanies < ActiveRecord::Migration
  def up
    add_column :companies, :active_st, :string, :null => false, :default => "notstart"
    companies = Company.all
    companies.each do |c|
      if ["X","Y"].include?(c.status.rank)
        c.update_attribute(:active_st, "pending")
      elsif ["Z","ZZ"].include? (c.status.rank)
        c.update_attribute(:active_st, "impossible")
      elsif ["P"].include? (c.status.rank)
        c.update_attribute(:active_st, "notstart")
      else
        c.update_attribute(:active_st, "active")
      end 
    end
  end

  def down
    remove_column :companies, :active_st
  end
end
