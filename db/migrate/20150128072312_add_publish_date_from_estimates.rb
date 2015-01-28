class AddPublishDateFromEstimates < ActiveRecord::Migration
  def change
    add_column :estimates, :publish_date, :date
    add_column :public_estimates, :publish_date, :date
  end
end
