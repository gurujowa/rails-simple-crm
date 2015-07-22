class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :company_id
      t.text :memo
      t.string :created_by

      t.timestamps
    end
  end
end
