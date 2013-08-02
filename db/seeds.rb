# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"
CSV.foreach('db/logs.csv') do |row|
  Log.create(:id =>row[0], :company_id => row[1], :status_id => row[2], :created_at => row[3], :created_by => row[4] )
end



