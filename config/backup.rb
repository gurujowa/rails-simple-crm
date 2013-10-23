# encoding: utf-8


database_yml = File.expand_path('../database.yml',  __FILE__)
email_yml = File.expand_path('../config/shared/email.yml',  __FILE__)
p email_yml
backup_yml = File.expand_path('../config/shared/backup.yml',  __FILE__)

RAILS_ENV    = ENV['RAILS_ENV'] || 'development'

require 'yaml'
config = YAML.load_file(database_yml)
mail_config = YAML.load_file(email_yml)
backup_config = YAML.load_file(backup_yml)


Backup::Model.new(:crm_backup, 'CRM SQLite File') do

  split_into_chunks_of 500
=begin
  # By default, relative paths will be relative to the directory
  # where `backup perform` is executed, and they will be expanded
  # to the root of the filesystem when added to the archive.
  #
  # If a `root` path is set, relative paths will be relative to the
  # given `root` path and will not be expanded when added to the archive.
  #
  #   archive.root '/path/to/archive/root'
  #
  # For more details, please see:
  # https://github.com/meskyanichi/backup/wiki/Archives
  #
=end
  archive :my_archive do |archive|
    # Run the `tar` command using `sudo`
    # archive.use_sudo
    archive.add config[RAILS_ENV]["database"]
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "/tmp/backups/"
    local.keep       = 5
  end

  store_with SCP do |server|
    server.username = backup_config[:username]
    server.password = backup_config[:password]
    server.ip       = backup_config[:ip]
    server.port     = 22
    server.path     = "~/backups/"
    server.keep     = 20
  end


  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  notify_by Mail do |mail|
    mail.on_success           = false
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "backup@yourbright.co.jp"
    mail.to                   = "yamashita.hayato@yourbright.co.jp"
    mail.address              = mail_config[RAILS_ENV][:address]
    mail.port                 = mail_config[RAILS_ENV][:port]
    mail.domain               = mail_config[RAILS_ENV][:domain]
    mail.user_name            = mail_config[RAILS_ENV][:user_name]
    mail.password             = mail_config[RAILS_ENV][:password]
    mail.authentication       = mail_config[RAILS_ENV][:authentication]
    mail.encryption           = :starttls
  end
end
