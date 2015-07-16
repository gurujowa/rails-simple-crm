namespace :lead do
  desc "about leads"

  task "depend" => :environment do
    his = LeadHistory.all
    his.each do |h|
      lead = Lead.find_by(id: h.lead_id)
      if lead.blank?
        puts h.lead_id.to_s  + "is blank"
        h.destroy
      end
    end
  end

end
