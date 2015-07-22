class AddFlagFromPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :resume_flg, :boolean
    add_column :periods, :report_flg, :boolean
  end
end
