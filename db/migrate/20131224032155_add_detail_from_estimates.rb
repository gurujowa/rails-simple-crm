class AddDetailFromEstimates < ActiveRecord::Migration
  def change
    add_column :estimates, :detail, :text
  end
end
