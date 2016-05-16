class AttendMailer < ApplicationMailer

  def teacher_mail(period, go)
    @period = period
    @teacher = period.teacher
    if go == "go"
      if Rails.env == "production"
        address = @teacher.email
      else
        raise "send teacher's mail can only production env"
      end
    else
      address = Rails.application.config.default_mailaddress
    end
    mail(to: address, subject: "出席確認(#{period.course.lead.name} - #{period.day})")
  end


  def alert_mail()
    @not_attend_periods = Period.today.where(attend_date: nil)
    if @not_attend_periods.present?
      mail(to: Rails.application.config.default_mailaddress, subject: "出席アラート")
    end
  end

end
