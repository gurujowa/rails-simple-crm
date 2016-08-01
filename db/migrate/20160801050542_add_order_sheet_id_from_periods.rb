class AddOrderSheetIdFromPeriods < ActiveRecord::Migration
  def change
    add_reference :periods, :order_sheet, index: true, foreign_key: true
  end
end
