class AlertMailer < ActionMailer::Base
  default from: "alert@yourbright.co.jp"

  def course(alerts)
    @alerts = alerts
    if Rails.env == 'production'
      to = "kenshu_g@yourbright.co.jp"
    else
      to = "yamashita.hayato@yourbright.co.jp"
    end

    mail(:to => to, :subject => "[アラート]期限が迫っているコースがあります。")
  end


  def end(courses)
    @courses = courses
    mail(:to => "kenshu_g@yourbright.co.jp", :subject => "本日終了したコースがあります")
  end
end
