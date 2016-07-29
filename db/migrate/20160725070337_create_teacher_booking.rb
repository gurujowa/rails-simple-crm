class CreateTeacherBooking < ActiveRecord::Migration
  def change
    create_table :teacher_bookings do |t|
      t.date :booking_date
      t.references :teacher, index: true, foreign_key: true
      t.datetime :expired_at
      t.string :name
    end

    add_column :periods, :price, :integer
    add_column :periods, :train_cost, :integer
  end
end
