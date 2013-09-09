require "csv"
  Teacher.destroy_all
CSV.foreach('db/teacher.csv') do |row|
  case row[5]
  when "○"
    work_possible = 0
  when "△"
    work_possible = 1
  when "×"
    work_possible = 2
  end
  
  orientation_flg = row[7] == "○" ? true : false
  profile_flg = row[8] == "○" ? true : false
  photo_flg = row[9] == "○" ? true : false
  regist_flg = row[10] == "○" ? true : false
  contract_flg = row[11] == "○" ? true : false
  
  c = Teacher.new(:id => row[0], :last_kanji => row[1], :first_kanji => row[2],
  :last_kana => row[3], :first_kana => row[4], :work_possible => work_possible, :genre => row[6], :orientation_flg => orientation_flg,
  :profile_flg => profile_flg , :photo_flg => photo_flg, :regist_flg => regist_flg, :contract_flg => contract_flg,:bill => row[14],
  :tel => row[15], :email => row[16])
  c.save!()
end