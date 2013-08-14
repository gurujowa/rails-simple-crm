class ContactMailer < ActionMailer::Base
  default from: "antena@yourbright.co.jp"

  def today(contacts)
    @contacts = contacts

    mail to: "gurujowa@gmail.com", subjects: "本日のコンタクト"
  end
end
