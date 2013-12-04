# encoding: utf-8


backup_yml = File.expand_path('../backup.yml',  __FILE__)

RAILS_ENV    = ENV['RAILS_ENV'] || 'development'

require 'yaml'
backup_config = YAML.load_file(backup_yml)


Backup::Model.new(:crm_dropbox, 'CRM SQLite File dropbox') do

  archive :my_archive do |archive|
    archive.add backup_config[RAILS_ENV][:backup]
  end

  store_with Dropbox do |db|
    db.api_key    = 'e2ym1h50dfmfsiy'
    db.api_secret = 's4g7fz1o6mmn60l'
    db.path       = '/backups'
    db.keep       = 2
  end

  compress_with Bzip2 do |compression|
    compression.level = 9
  end

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
    mail.address              = backup_config[RAILS_ENV][:address]
    mail.port                 = backup_config[RAILS_ENV][:port]
    mail.domain               = backup_config[RAILS_ENV][:domain]
    mail.user_name            = backup_config[RAILS_ENV][:user_name]
    mail.password             = backup_config[RAILS_ENV][:password]
    mail.authentication       = backup_config[RAILS_ENV][:authentication]
    mail.encryption           = :starttls
  end

end

Backup::Model.new(:crm_backup, 'CRM SQLite File') do

  split_into_chunks_of 500
  archive :my_archive do |archive|
    archive.add backup_config[RAILS_ENV][:backup]
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
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "/tmp/backups/"
    local.keep       = 5
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
    mail.address              = backup_config[RAILS_ENV][:address]
    mail.port                 = backup_config[RAILS_ENV][:port]
    mail.domain               = backup_config[RAILS_ENV][:domain]
    mail.user_name            = backup_config[RAILS_ENV][:user_name]
    mail.password             = backup_config[RAILS_ENV][:password]
    mail.authentication       = backup_config[RAILS_ENV][:authentication]
    mail.encryption           = :starttls
  end
end
