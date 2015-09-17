class AddLeadIdFromEstimates < ActiveRecord::Migration
  def change
    add_column :estimates, :lead_id, :integer

    estimates = Estimate.all
    estimates.each do |e|
      e.lead_id = e.client_id
      e.save!
    end

    add_foreign_key :estimates, :leads
    remove_column :estimates, :client_type
    remove_column :estimates, :client_id
  end
end
