# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"
CSV.foreach('db/course.csv') do |row|
  order_flg = row[3] == "OK" ? true : false
  report_flg = row[4] == "OK" ? true : false
  book_flg = row[5] == "OK" ? true : false

  c = Course.new(:id => row[0], :name => row[1], :company_id => row[2],
  :order_flg => order_flg, :report_flg => report_flg, :book_flg => book_flg)
  c.save!(:validate => false)
end