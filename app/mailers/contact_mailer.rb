class ContactMailer < ActionMailer::Base
  default from: "antenna@yourbright.co.jp"

  def today(contacts)
    @contacts = contacts

    if Rails.env == 'production'
      to = "antenna@yourbright.co.jp"
    else
      to = "yamashita.hayato@yourbright.co.jp"
    end

    mail(:to => to, :subject => "本日のコンタクト内容")
  end
end
