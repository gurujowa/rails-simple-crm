class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
       t.string :title, :null => false
       t.references :company, :null => false
       t.date :expired
       t.integer :tax_rate, :null => false, :default => 0
       t.boolean :send_flg, :null => false, :default => false
       t.text :memo
       t.timestamps
    end

    create_table :estimate_lines do |t|
       t.string :name, :null => false
       t.integer :unit_price, :null => false
       t.integer :quantity, :null => false
       t.references :estimate, :null => false
       t.timestamps
    end
  end
end
