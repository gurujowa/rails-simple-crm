class CreateBillingPlans < ActiveRecord::Migration
  def change
    create_table :billing_plans do |t|
      t.string :name, null: false
      t.references :company, index: true, null: false
      t.integer :tax_rate, null:false, default: 0
      t.string :status, null:false, default: "draft"

      t.timestamps
    end
  end
end
