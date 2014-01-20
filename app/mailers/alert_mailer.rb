class AlertMailer < ActionMailer::Base
  default from: "alert@yourbright.co.jp"

  def course(alerts)
    @alerts = alerts
    mail(:to => mail_to,
         :subject => "[アラート]期限が迫っているコースがあります。")
  end

  def send_error(message)
    AlertMailer.error(message).deliver
  end

  def error(message)
    @message = message
    mail(:to => mail_to, :subject => message)
  end

  def reminder(period)
    @period = period
    address = ["kenshu_g@yourbright.co.jp"]

    if @period.teacher.email.present?
      address << [@period.teacher.email]
    else
      send_error("講師のメールアドレスが存在しません。講師名＝" + @period.teacher.name)
    end

    if @period.course.company.empty? or @period.course.company.mail.blank?
      send_error("会社の連絡先が存在しません。会社名＝" + @period.course.company.client_name)
    else
      mailad = @period.course.company.mail
      address << mailad
    end

    p address.inspect

    if Rails.env == 'production'
      to = address
    else
      to = "yamashita.hayato@yourbright.co.jp"
    end

    mail(:to => to, :subject => %Q{[ユアブライト]明日、#{period.start_time.strftime("%H:%M")}より研修が開始します。})
  end

  def end(courses)
    @courses = courses
    mail(:to => mail_to, :subject => "本日終了したコースがあります")
  end

  def mail_to
    if Rails.env == 'production'
      to = "kenshu_g@yourbright.co.jp"
    else
      to = "yamashita.hayato@yourbright.co.jp"
    end
    to
  end
end
