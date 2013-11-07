class CreateClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string :last_name, :null => false
      t.string :first_name
      t.string :last_kana
      t.string :first_kana
      t.string :tel
      t.string :fax
      t.string :mail
      t.integer :gender, :null => false
      t.string :official_position
      t.references :company, :null => false
      t.text :memo

      t.timestamps
    end

    companies = Company.all
    companies.each do |c|
      if c.client_person.present?
        mailaddress = c.mail
        clie = Client.create!(:last_name => c.client_person, :tel => c.tel, :fax => c.fax, :mail => mailaddress, :gender => 3, :company_id => c.id)
      end
    end
  end

  def down
    drop_table :clients
  end
end
