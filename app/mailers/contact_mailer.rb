class ContactMailer < ActionMailer::Base
  default from: "antenna@yourbright.co.jp"

  def today(contacts)
    @contacts = contacts

    mail(:to => "antenna@yourbright.co.jp", :subject => "本日のコンタクト内容")
  end
end
