class CreateLeadHistory < ActiveRecord::Migration
  def change
    create_table :lead_histories do |t|
      t.date :approach_day, required: true
      t.references :lead_history_status,index: true, required: true
      t.references :user, index: true, required: true
      t.date :next_approach_day
      t.text :memo
      t.references :lead, index: true, required: true

      t.timestamps
    end

  add_column :leads, :city, :string
    
  end
end
