class AddGoogleFromPeriod < ActiveRecord::Migration
  def change
    add_column :periods, :google_flg, :boolean, :null => false, :default => false
  end
end
