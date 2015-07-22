class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      ## Database authenticatable
      t.remove :password
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      #t.timestamps
    end

    User.find(1).update_attributes!(email: "tobita.sana@yourbright.co.jp")
    User.find(2).update_attributes!(email: "fujimoto.seiya@yourbright.co.jp")
    User.find(3).update_attributes!(email: "mano.ryota@yourbright.co.jp")
    User.find(4).update_attributes!(email: "yamashita.hayato@yourbright.co.jp")
    User.find(5).update_attributes!(email: "tazaki.kaoruko@yourbright.co.jp")
    User.find(6).update_attributes!(email: "miwa@yourbright.co.jp")
    User.find(7).update_attributes!(email: "fukuda.yutaka@yourbright.co.jp")
    User.find(8).update_attributes!(email: "info@yourbright.co.jp")
    User.find(9).update_attributes!(email: "oda.shin@yourbright.co.jp")

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
