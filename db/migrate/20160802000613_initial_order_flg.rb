class InitialOrderFlg < ActiveRecord::Migration
  def up
    Period.where("day < ?", Time.current.beginning_of_month).update_all(order_sheet_id: 1)
  end

  def down
    Period.where("day < ?", Time.current.beginning_of_month).update_all(order_sheet_id: nil)
  end
end
