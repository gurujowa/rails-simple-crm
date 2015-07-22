class AddShippedFlagFromLeadHistories < ActiveRecord::Migration
  def change
    add_column :lead_histories, :shipped_at, :datetime
    lead_histories = LeadHistory.tagged_with("資料郵送済")
    lead_histories.each do |lh|
      lh.tag_all_list.each do |t|
        if t[:name] == "資料郵送済"
          lh.shipped_at = t[:created_at]
          lh.save
        end
      end
    end
  end
end
