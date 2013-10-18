class AlertMailer < ActionMailer::Base
  default from: "alert@yourbright.co.jp"

  def course(alert)
    @alert = alert.errors
    mail(:to => "kenshu_g@yourbright.co.jp", :subject => "[アラート]期限が迫っているコースがあります。")
  end


  def end(courses)
    @courses = courses
    mail(:to => "kenshu_g@yourbright.co.jp", :subject => "本日終了したコースがあります")
  end
end
