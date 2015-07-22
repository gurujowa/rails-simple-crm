class CreateCampaigns < ActiveRecord::Migration
  def up
    create_table :campaigns do |t|
      t.string :name
      t.integer :bill, :null => false
      t.integer :sent, :null => false
      t.date :start_date
      t.text :memo

      t.timestamps
    end
    add_reference :companies, :campaign, index: true

    Campaign.create({name: 'FAX-汎用', id: 1, bill: 0, sent: 0})
    Campaign.create({name: 'ホームページ-汎用', id: 2, bill: 0, sent: 0})
    Campaign.create({name: '自社テレアポ', id: 3, bill: 0, sent: 0})
    Campaign.create({name: '紹介', id: 4, bill: 0, sent: 0})
    Campaign.create({name: '代理店', id: 5, bill: 0, sent: 0})
    Campaign.create({name: 'オフィスコム - Tel代行', id: 6, bill: 300000, sent: 1000})
    Campaign.create({name: 'ホームページ', id: 7, bill: 0, sent: 0})
    Campaign.create({name: 'その他', id: 99, bill: 0, sent: 0})

    companies = Company.all

    index = 0
    companies.each do |c|
       case c.lead
       when "FAX"
          c.update_attribute(:campaign_id, 1)
       when "HP"
          c.update_attribute(:campaign_id, 2)
       when "wamnet"
          c.update_attribute(:campaign_id, 3)
       when "インポート"
          c.update_attribute(:campaign_id, 3)
       when "ダイレクトメール"
          c.update_attribute(:campaign_id, 7)
       when "テレアポ代行"
          c.update_attribute(:campaign_id, 6)
       when "ホームページ"
          c.update_attribute(:campaign_id, 2)
       when "代理店"
          c.update_attribute(:campaign_id, 5)
       when "福祉ナビ"
          c.update_attribute(:campaign_id, 3)
       when "紹介"
          c.update_attribute(:campaign_id, 4)
       when "自社テレアポ"
          c.update_attribute(:campaign_id, 3)
       when "その他"
          c.update_attribute(:campaign_id, 99)
       else
          c.update_attribute(:campaign_id,99)
       end
    end

    change_column :companies, :campaign_id, :integer, :null => false

  end

  def down
      drop_table :campaigns
      remove_reference :companies, :campaign
  end
end
