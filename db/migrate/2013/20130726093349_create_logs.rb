class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :company_id
      t.integer :status_id

      t.timestamps
    end
  end
end
