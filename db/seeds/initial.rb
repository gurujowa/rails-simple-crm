# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"
CSV.foreach('db/company.csv') do |row|
  c = Company.new(:id => row[0], :client_name => row[1], :category => row[2],\
  :tel=>row[3],:fax=>row[4],:mail=>row[5],:status_id=>row[6],:client_person=>row[7],:zipcode=>row[8],\
  :prefecture=>row[9],:city=>row[10],:address=>row[11],:building=>row[12],:lead=>row[13],\
  :updated_at=>row[15],:updated_by=>row[16],:created_at=>row[17],:created_by=>row[18])
  c.save!(:validate => false)
end

CSV.foreach('db/contact.csv') do |row|
  Contact.create(:id =>row[0], :company_id => row[1], :memo => row[2])
end

CSV.foreach('db/status.csv') do |row|
  Status.create(:id =>row[1], :name => row[0], :rank => row[2] , :active => row[3])
end

CSV.foreach('db/logs.csv') do |row|
  Log.create(:id =>row[0], :company_id => row[1], :status_id => row[2], :created_at => row[3], :created_by => row[4] )
end

