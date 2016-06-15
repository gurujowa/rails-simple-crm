class AddDisplayFlgFromLeadHistoryStatuses < ActiveRecord::Migration
  def change
    add_column :lead_history_statuses, :display_flg, :boolean, null: false, default: true
  end
end
