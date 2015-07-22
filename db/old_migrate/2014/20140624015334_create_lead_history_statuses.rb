class CreateLeadHistoryStatuses < ActiveRecord::Migration
  def change
    create_table :lead_history_statuses do |t|
      t.string :name
      t.string :progress
      t.string :color

      t.timestamps
    end

    LeadHistoryStatus.create name: "電話対応", progress: "ing", color: "C8E4FF"
    LeadHistoryStatus.create name: "メール対応", progress: "ing", color: "C8E4FF"
    LeadHistoryStatus.create name: "不在・離席", progress: "ing", color: "FAF18D"
    LeadHistoryStatus.create name: "時期改め", progress: "ing", color: "FAF18D"
    LeadHistoryStatus.create name: "再アプローチ", progress: "ing", color: "577A05"
    LeadHistoryStatus.create name: "保留・検討", progress: "ing", color: "577A05"
    LeadHistoryStatus.create name: "アポイント", progress: "done", color: "F7863C"
    LeadHistoryStatus.create name: "資料請求", progress: "done", color: "F7863C"
    LeadHistoryStatus.create name: "担当NG", progress: "done", color: "7e5f00"
    LeadHistoryStatus.create name: "受付NG", progress: "done", color: "7e5f00"
    LeadHistoryStatus.create name: "ガチャ切り", progress: "done", color: "CD4232"
    LeadHistoryStatus.create name: "クレーム", progress: "done", color: "CD4232"
    LeadHistoryStatus.create name: "不通・移転", progress: "forbidden", color: "444444"
    LeadHistoryStatus.create name: "荷電禁止", progress: "forbidden", color: "444444"

  end
end
