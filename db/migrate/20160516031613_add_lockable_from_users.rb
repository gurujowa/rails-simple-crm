class AddLockableFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :faild_attempts, :integer, default: 0, null: false
    add_column :users, :locked_at, :datetime
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :datetime
  end
end
