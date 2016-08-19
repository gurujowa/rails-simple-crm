class AddSendAlertFlgFromTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :send_alert_flg, :boolean, null: false, default: true
  end
end
