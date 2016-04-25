class AddAddressIdFromPeriods < ActiveRecord::Migration
  def change
    add_reference :periods, :course_address, index: true, foreign_key: true
  end
end
