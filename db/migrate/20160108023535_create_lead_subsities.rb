class CreateLeadSubsities < ActiveRecord::Migration
  def change
    create_table :lead_subsities do |t|
      t.string :name
      t.date :start
      t.date :end
      t.text :memo
      t.belongs_to :lead, index: true, foreign_key: true
      t.belongs_to :subsity, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
