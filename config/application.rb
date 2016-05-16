require File.expand_path('../boot', __FILE__)

require 'csv'
require 'kconv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Mycrm
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    #config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Tokyo'
    config.to_prepare do
      Devise::SessionsController.layout "devise" 
    end
    config.autoload_paths += Dir["#{config.root}/app/validators"]

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    I18n.enforce_available_locales = true

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:               Rails.application.secrets.smtp_address,
      port:                  587,
      domain:                'mob.yourbright.co.jp',
      user_name:             Rails.application.secrets.smtp_user,
      password:              Rails.application.secrets.smtp_pass,
      authentication:        'plain',
      enable_starttls_auto:  true
    }

    config.default_mailaddress = 'yamashita.hayato@yourbright.co.jp'
  end
end
