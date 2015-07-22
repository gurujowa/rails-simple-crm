class ChangeDateTimeApproachDay < ActiveRecord::Migration
  def change
    change_column :lead_histories, :approach_day,  :datetime
  end
end
