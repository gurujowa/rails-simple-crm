class AlertMailer < ActionMailer::Base
  default from: "alert@yourbright.co.jp"

  def course(alert)

    @alert = alert.errors
    mail(:to => "antenna@yourbright.co.jp", :subject => "[アラート]期限が迫っているコースがあります。")
  end
end
