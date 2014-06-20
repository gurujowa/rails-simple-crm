class CreateLeadHistory < ActiveRecord::Migration
  def change
    create_table :lead_histories do |t|
      t.date :approach_day
      t.integer :category
      t.date :next_approach_day
      t.text :memo
      t.references :lead, index: true

      t.timestamps
    end

  add_column :leads, :city, :string
    
  end
end
