class ConvertShippedFromLead < ActiveRecord::Migration
  def up
    shipped = LeadHistory.tagged_with("資料郵送済")
    shipped.each do |lh|
      l = lh.lead
      l.tag_list.add("初回資料郵送済")
      l.save
    end
  end
end
