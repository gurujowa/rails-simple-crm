class ChangeOrderAvailable < ActiveRecord::Migration
  def up
    add_column :periods, :order_avail, :integer, null: false, default: 0
    periods = Period.all
    periods.each do |p|
      if p.order_available == true
        p.update(order_avail: Period.order_avail[:ok])
      end
    end
    remove_column :periods, :order_available, :boolean, null: false, default: false
  end

  def down
    add_column :periods, :order_available, :boolean, null: false, default: false
    remove_column :periods, :order_avail, :integer, null: false, default: false
  end
end
