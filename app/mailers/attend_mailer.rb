class AttendMailer < ApplicationMailer

  def teacher_mail(period,env)
    @period = period
    @teacher = period.teacher

    if env == "development"
      to = "yamashita.hayato@yourbright.co.jp"
    elsif env == "production"
      to = @teacher.email
    else
      raise "environment is only development and production"
    end

    mail(to: to, subject: "出席確認(#{period.course.lead.name} - #{period.day})")
  end

end
