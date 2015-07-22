class CreateEstimateSubsities < ActiveRecord::Migration
  def change
    create_table :estimate_subsities do |t|
      t.string :name
      t.integer :price, null: false, default: 0
      t.integer :people
      t.integer :estimate_id

      t.timestamps
    end
  end
end
