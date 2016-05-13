class AttendMailer < ApplicationMailer

  def welcome_email()
    mail(to: "gurujowa@gmail.com", subject: 'Welcome to My Awesome Site')
  end

end
