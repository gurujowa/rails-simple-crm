require "csv"
Period.destroy_all
CSV.foreach('db/period.csv') do |row|
  
  profile_flg = row[8] == "OK" ? true : false
  photo_flg = row[9] == "OK" ? true : false
  
  c = Period.new(:id => row[0], :course_id => row[1], :day => row[2],
  :teacher_id => row[3], :start_time => row[4], :end_time => row[5], :break_start => row[6], :break_end => row[7],
  :resume_flg => profile_flg , :report_flg => photo_flg, :memo => row[10])
  c.save!()
end