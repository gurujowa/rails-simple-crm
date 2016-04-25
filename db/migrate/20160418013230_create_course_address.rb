class CreateCourseAddress < ActiveRecord::Migration

  def up
    create_table :course_addresses do |t|
      t.string :name
      t.string :address
      t.string :station
      t.string :responsible
      t.string :tel
      t.boolean :projector
      t.string :projector_detail
      t.boolean :board
      t.string :board_detail
      t.references :course
      t.text :memo
    end

    courses = Course.all
    courses.each do |c|
      CourseAddress.create!({ address: c.address, station: c.station, responsible: c.responsible, tel: c.tel, memo: c.memo, course_id: c.id })
    end
  end

  def down
    drop_table :course_addresses
  end

end
