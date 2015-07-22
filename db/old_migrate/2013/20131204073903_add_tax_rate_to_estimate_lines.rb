class AddTaxRateToEstimateLines < ActiveRecord::Migration
  def change
    add_column :estimate_lines, :tax_rate, :integer, null: false, default: 0
    EstimateLine.all.each do |e|
      if e.estimate.tax_rate == 5
          e.update_attributes!(tax_rate: 5)
      end
    end
    remove_column :estimates, :tax_rate, :integer
  end
end
