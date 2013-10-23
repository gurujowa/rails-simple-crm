if Rails.env != 'test'
  email_settings = YAML::load(File.open("#{Rails.root.to_s}/config/shared/email.yml"))
  ActionMailer::Base.smtp_settings = email_settings[Rails.env] unless email_settings[Rails.env].nil?
end
