class AddApproachdayToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :approach_day, :date
  end
end
