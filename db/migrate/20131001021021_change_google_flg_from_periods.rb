class ChangeGoogleFlgFromPeriods < ActiveRecord::Migration
  def up
    remove_column  :periods, :google_flg
    remove_column  :periods, :end_report_flg
    add_column  :periods, :google_id, :string
  end

  def down
    add_column  :periods,:google_flg, :boolean
    add_column  :periods, :end_report_flg, :boolean
    remove_column :periods, :google_id
  end
end
