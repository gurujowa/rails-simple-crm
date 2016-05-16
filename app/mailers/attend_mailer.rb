class AttendMailer < ApplicationMailer

  def teacher_mail(period)
    @period = period
    @teacher = period.teacher
    mail(to: mail_address(@teacher.email), subject: "出席確認(#{period.course.lead.name} - #{period.day})")
  end

  def alert_mail()
    @not_attend_periods = Period.today.where(attend_date: nil)
    if @not_attend_periods.present?
      mail(to: mail_address("kenshu@yourbright.co.jp"), subject: "出席アラート")
    end
  end

  def mail_address(production_mail)
    if Rails.env == "development"
      return Rails.application.config.default_mailaddress
    elsif Rails.env == "production"
      return production_mail
    else
      raise "invalid env #{Rails.env}"
    end

  end
end
