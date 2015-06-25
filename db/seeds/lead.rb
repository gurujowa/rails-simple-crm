require "csv"
require 'kconv'
require 'tempfile'

def tel_encode(input)
    i = input.to_s.gsub "－", "-"
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

table = CSV.table('db/nakano.csv',encoding: "Windows-31J:UTF-8")
table.each do |r|
  if r[:client_name].blank?
    next
  end
  lead = Lead.find_by(tel: tel_encode(r[:tel]))

  if lead.blank?
    puts "new lead added"
    lead = Lead.new(:name => r[:client_name],:zipcode => r[:zip_code])
    lead.tel =  tel_encode(r[:tel])
    lead.fax = tel_encode(r[:fax])
    lead.tag_list.add(r[:category])
    #郵便番号
    lead.zipcode.gsub! "〒",""



    #住所
    lead.url = r[:url]
    st = r[:address].to_s.split(" ")
    ad = nil
    if st.length == 2
      ad = st[0]
      lead.building = st[1]
    else
      ad = r[:address]
    end
    lead.prefecture = r[:prefecture]
    lead.city = r[:city]
    lead.street = ad
    lead.street.to_s.strip
  end

  lead.memo = <<EOL
  カテゴリ：#{r[:category]}
  管理者：#{r[:client_person]}
  管理者の役職：#{r[:client_post]}
  スタッフ数：#{r[:staff]}
  法人の種類：#{r[:company]}
  法人名：#{r[:company_name]}
  法人の住所：#{r[:company_address]}
  法人の電話番号：#{r[:company_tel]}
  法人のFAX：#{r[:company_fax]}
  法人代表者：#{r[:company_person]}
  法人代表者の役職名：#{r[:company_post]}
EOL

  lead.corporation_name =  r[:company_name]
  lead.tag_list.add("ランクA")



    unless lead.save
      p lead.tel
      p lead.prefecture
      p lead.city
      p lead.errors.full_messages.inspect
    end

end
