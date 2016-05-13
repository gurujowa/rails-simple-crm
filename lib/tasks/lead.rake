namespace :lead do
  desc "about leads"

  task "welcome_email" => :environment do
    AttendMailer.welcome_email().deliver_now
  end

  task "teacher_order" => :environment do
    to = TeacherOrder.all

    to.each do |t|
      if t.courses.length > 1
        p t.courses.inspect
      elsif t.courses.length == 1
        t.course_id = t.courses.first.id
        t.save!
      else
        t.destroy
      end
    end
  end

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
