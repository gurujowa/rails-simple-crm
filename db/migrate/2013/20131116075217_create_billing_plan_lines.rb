class CreateBillingPlanLines < ActiveRecord::Migration
  def change
    create_table :billing_plan_lines do |t|
      t.date :due_date, null:false
      t.date :bill_date, null:false
      t.date :accural_date, null:false
      t.integer :unit_price, null:false
      t.integer :quantity, null:false
      t.text :memo
      t.references :billing_plan, index: true

      t.timestamps
    end
  end
end
