class ContactsMailer < ActionMailer::Base
  default from: "antena@yourbright.co.jp"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contacts.today.subject
  #
  def today
    @greeting = "Hi"

    mail(to: "gurujowa@gmail.com")
  end
end
