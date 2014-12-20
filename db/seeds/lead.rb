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

table = CSV.table('db/saitama.csv')

table.each do |r|
  if r[:client_name].blank?
    next
  end
  lead = Lead.find_by(tel: tel_encode(r[:tel]))

  if lead.blank?
    lead = Lead.new(:name => r[:client_name],:zipcode => r[:zip_code])
    lead.tel =  tel_encode(r[:tel])
    lead.fax = tel_encode(r[:fax])
    lead.tag_list.add(r[:category])
    lead.url = r[:url]
    #郵便番号
    lead.zipcode.gsub! "〒",""

  end

    #住所
    st = r[:address].split(" ")
    ad = nil
    if st.length == 2
      ad = st[0]
      lead.building = st[1]
    else
      ad = r[:address]
    end

    adb = ad.match(/^(京都府|.+?[都道府県])(大和郡山市|蒲郡市|小郡市|郡上市|杵島郡大町町|佐波郡玉村町|(?:[^市]*?|余市|高市)郡.+?[町村]|(?:石狩|伊達|八戸|盛岡|奥州|南相馬|上越|姫路|宇陀|黒部|小諸|富山|岩国|周南|佐伯|西海)市|.*?[^0-9一二三四五六七八九十上下]区|四日市市|廿日市市|.+?市|.+?町|.+?村)(.*?)([0-9-]*?)$/)
    if adb.present?
      lead.prefecture = adb[1].strip
      lead.city = adb[2]
      lead.street = adb[3] + adb[4]
      lead.street.strip
    else
      p r[:address]
    end


  lead.memo = <<EOL
カテゴリ：#{r[:category]}
管理者：#{r[:client_person]}
管理者の役職：#{r[:client_post]}
法人の種類：#{r[:company]}
法人名：#{r[:company_name]}
法人の住所：#{r[:company_address]}
法人の電話番号：#{r[:company_tel]}
法人のFAX：#{r[:company_fax]}
法人代表者：#{r[:company_person]}
法人代表者の役職名：#{r[:company_post]}
EOL

    unless lead.save
      p lead.tel
      p lead.prefecture
      p lead.city
      p lead.errors.full_messages.inspect
    end

end
