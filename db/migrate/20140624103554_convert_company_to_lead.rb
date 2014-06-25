class ConvertCompanyToLead < ActiveRecord::Migration
  def up
    rename_column :leads, :zip_code, :zipcode
    statuses = Status.where(rank: "P")
    nego_list = []
    statuses.each do |s|
      s.negos.each do |n|
        nego_list << n
      end
    end
    nego_list.each do |n|
      lead = Lead.new
      lead.name = n.company.name
      lead.tel = n.company.tel
      lead.fax = n.company.fax
      lead.email = n.company.mail
      lead.person_name = n.company.client_person

      if n.company.clients.present?
        lead.person_kana = n.company.clients.first.last_kana
      end

      lead.zipcode = n.company.zipcode
      lead.prefecture = n.company.prefecture
      lead.city = n.company.city
      lead.street = n.company.address
      lead.building = n.company.building

      n.company.contacts.each do |c|
        his = LeadHistory.new
        his.memo = c.memo
        his.lead_history_status_id = 1
        his.approach_day = c.created_at
        his.user_id = n.user_id
        lead.lead_histories << his
        lead.save!
      end

      lead.save!
    end
  end

  def down
    LeadHistory.delete_all
    Lead.delete_all
  end
end
