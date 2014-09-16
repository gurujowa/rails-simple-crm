class CreateLeadInterviews < ActiveRecord::Migration
  def change
    create_table :lead_interviews do |t|
      t.integer :regular_staff
      t.integer :nonregular_staff
      t.string :solvency
      t.string :time
      t.references :lead, index: true

      t.timestamps
    end
  end
end
