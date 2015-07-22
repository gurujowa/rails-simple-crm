class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name, null: false
      t.string :tel, null: false
      t.string :fax
      t.string :email
      t.string :person_name
      t.string :person_kana
      t.string :person_post
      t.string :url
      t.string :zip_code
      t.string :prefecture
      t.string :street
      t.string :building
      t.text :memo
      t.references :user, index: true
      t.integer :star

      t.timestamps
    end
  end
end
