class AddResumeStatusFromPeriods < ActiveRecord::Migration
  def up
    add_column :periods, :resume_status, :string, null: false, default: :notstart
    Period.where("day <= ?", Time.current.prev_week).update_all(resume_status: :complete)
  end

  def down
    remove_column :periods, :resume_status
  end
end
