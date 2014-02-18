class RemoveStatusFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :status_id, :integer
  end
end
