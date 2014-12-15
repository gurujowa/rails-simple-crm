class AddDmToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :dm_st, :boolean, :default => false
    Status.update_all ["dm_st = ?",false]
  end
end
