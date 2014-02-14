class CreateNego < ActiveRecord::Migration
  def change
    create_table :negos do |t|
      t.string :name
      t.references :company,  null: false
      t.references :user,  null: false
      t.string :stage, null: false
      t.text :memo

      t.timestamps
    end
  end
end
