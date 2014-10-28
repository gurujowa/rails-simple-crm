require "csv"

#社会福祉法人（社協以外）　医療法人　営利法人　NPO法人　その他法人
open("db/tag_import.csv", "rb:Shift_JIS:UTF-8", undef: :replace) do |f|
  CSV.new(f).each do |row|
    lead = Lead.find(row[0])
    lead.tag_list.add("11月アタック")
    lead.save
  end
end
