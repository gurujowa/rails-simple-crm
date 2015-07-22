class ChangeActiveName < ActiveRecord::Migration
  def up
    c = Company.where(active_st: :active)
    c.update_all :active_st => :active_c
  end

  def down
    c = Company.where(active_st: :active_c)
    c.update_all :active_st => :active

  end
end
