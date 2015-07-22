class AlterNegoStatusId < ActiveRecord::Migration
  def change
    rename_column :negos, :stage, :status_id
  end
end
