require "csv"


CSV.foreach('shared/rojin-tokyo.csv',  encoding: "Shift_JIS:UTF-8") do |row|
  c = Company.new(:client_name => row[1],
  :tel=>row[7].strip,:zipcode => row[5], :prefecture=>"東京都" , :city=>row[9],:address=>row[10],
  :created_by=>2, :campaign_id => 100, :status_id =>2, :chance => 0, :sales_person => 2)
  c.save!
  p c.tel
end
