class AlertMailer < ActionMailer::Base
  default from: "alert@yourbright.co.jp"

  def course(alerts)
    @alerts = alerts
    mail(:to => mail_to,
         :subject => "[アラート]期限が迫っているコースがあります。")
  end

  def error(message)
    m = mail(:to => mail_to, :subject => message) do |format|
      format.text { render text: message}
    end
    m.deliver
  end

  def reminder(period)
    @period = period

    if @period.teacher.email.present?
      address = [@period.teacher.email]
    else
      error("講師のメールアドレスが存在しません。講師名＝" + @period.teacher.name)
    end

    if @period.course.company.clients.empty? or !@period.course.company.clients.first.mail.present?
      error("会社の連絡先が存在しません。会社名＝" + @period.course.company.name)
    else
      address << @period.course.company.clients.first.mail
    end
    address << "kenshu_g@yourbright.co.jp"

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
