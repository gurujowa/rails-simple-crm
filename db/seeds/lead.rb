require "csv"
require 'nkf' 

def tel_encode(input)
    i = input.gsub "－", "-"
    i = i.gsub "－","-"
    i = i.gsub "/" , ""
    i = i.gsub "." , ""
    i = i.gsub "、" , ""
    i = i.gsub /(\d{2,4})[\(（\-\?](\d{2,4})[）\?\-\)](\d{2,4})/ , "\\1-\\2-\\3"
    i = i.gsub "（", ""
    i = i.strip
    i = NKF.nkf('-m0Z1 -w', i)
    i
end

#社会福祉法人（社協以外）　医療法人　営利法人　NPO法人　その他法人
open("db/wamnet.csv", "rb:Shift_JIS:UTF-8", undef: :replace) do |f|
CSV.new(f).each do |row|
  if row[4].blank?
    next
  end
  lead = Lead.find_by(tel: tel_encode(row[4]))
  if lead.blank?
    lead = Lead.new(:name => row[0],:zipcode => row[1],:prefecture=>"東京都",
     person_name: row[6], person_post: row[7], corporation_name: row[10])
    lead.tel =  tel_encode(row[4])
    lead.fax = tel_encode(row[5])
    #郵便番号
    lead.zipcode.gsub! "〒",""
  end


  lead.memo = <<"EOF"
カテゴリ：#{row[3]}
管理者：#{row[6]}
管理者の役職：#{row[7]}
法人の種類：#{row[9]}
法人名：#{row[10]}
法人の住所：#{row[11]}
法人の電話番号：#{row[12]}
法人のFAX：#{row[13]}
法人代表者：#{row[14]}
法人代表者の約職名：#{row[15]}

EOF


    #住所
    st = row[2].split(" ")
    ad = nil
    if st.length == 2
      ad = st[0]
      lead.building = st[1]
    else
      ad = row[2]
    end

    adb = ad.match(/^(京都府|.+?[都道府県])(大和郡山市|蒲郡市|小郡市|郡上市|杵島郡大町町|佐波郡玉村町|(?:[^市]*?|余市|高市)郡.+?[町村]|(?:石狩|伊達|八戸|盛岡|奥州|南相馬|上越|姫路|宇陀|黒部|小諸|富山|岩国|周南|佐伯|西海)市|.*?[^0-9一二三四五六七八九十上下]区|四日市市|廿日市市|.+?市|.+?町|.+?村)(.*?)([0-9-]*?)$/)
    if adb.present?
      lead.prefecture = adb[1]
      lead.city = adb[2]
      lead.street = adb[3] + adb[4]
    else
      p row[2]
    end

  Lead.transaction do
    unless lead.save
      p tel_encode(row[4])
      p row[2]
      raise lead.errors.full_messages.inspect
    end
  end
  #p lead.tel
end
end


