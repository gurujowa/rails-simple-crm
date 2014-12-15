class AddDetailFromEstimates < ActiveRecord::Migration
  def change
    add_column :estimate_lines, :detail, :text
  end
end
