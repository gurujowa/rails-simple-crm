class AddObserveIdFromPeriods < ActiveRecord::Migration
  def change
    add_reference :periods, :user, index: true
  end
end
