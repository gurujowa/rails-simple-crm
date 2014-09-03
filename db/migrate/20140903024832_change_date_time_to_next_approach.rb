class ChangeDateTimeToNextApproach < ActiveRecord::Migration
  def change
    change_column :lead_histories, :next_approach_day, :datetime
  end
end
