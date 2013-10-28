class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :last_name, :null => false
      t.string :first_name
      t.string :last_kana
      t.string :first_kana
      t.string :tel
      t.string :fax
      t.string :email
      t.integer :gender, :null => false
      t.string :official_position
      t.references :company, :null => false
      t.text :memo

      t.timestamps
    end
  end
end
