class ConvertFromCompanyToLead < ActiveRecord::Migration
  def up
    companies = Company.all
    companies.each do |c|
      lead = Lead.new(name: c.name, tel: c.tel,fax: c.fax, email: c.mail, person_name: c.clients.first.name, zipcode: c.zipcode, prefecture: c.prefecture, city: c.city, street: c.address, building: c.building, memo: c.memo )
      old_lead = Lead.find_by(tel: c.tel)
      if old_lead.present?
        lead = old_lead
      end
      lead.tag_list.add("既存客コンバート")
      lead.dm_flg = true
      lead.contract_flg = true
      lead.save
    end

    remove_column :courses, :order_flg
    remove_column :courses, :book_flg
    remove_column :courses, :resume_flg
    remove_column :courses, :diploma_flg
    remove_column :courses, :attendee_table_flg
    remove_column :courses, :observe_flg
    remove_column :courses, :total_time_minute
    remove_column :courses, :total_time_manual_flg
    add_column :courses, :lead_id, :integer

    courses = Course.all
    courses.each do |c|
      tel = Company.find(c.company_id).tel
      lead = Lead.find_by tel: tel
      c.lead_id = lead.id
      c.save!
    end

    change_column :courses, :lead_id, :integer, null: false

    estimates = Estimate.all
    estimates.each do |e|
      if e.client_type == "company"
        tel = Company.find(e.client_id).tel
        lead = Lead.find_by tel: tel
        e.client_id = lead.id
        e.save!
      end
    end



    add_column :billing_plans, :lead_id, :integer
    BillingPlan.destroy 86
    bb = BillingPlan.find_by company_id: 20297
    bb.destroy

    bil = BillingPlan.all
    bil.each do |b|
      if b.company_id == 21105
        b.destroy
        next
      end
      company = Company.find(b.company_id)
      tel = company.tel
      lead = Lead.find_by tel: tel
      b.lead_id = lead.id
      b.save!
    end
    change_column :billing_plans, :lead_id, :integer, null: false
    remove_column :billing_plans, :company_id
  end

  def down
     # not much we can do to restore deleted data
    raise ActiveRecord::IrreversibleMigration, "Can't recover this method"
  end

end
