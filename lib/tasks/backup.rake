namespace :backup do
  task "dropbox" => :environment do

    Dropbox::API::Config.app_key    = 'e2ym1h50dfmfsiy'
    Dropbox::API::Config.app_secret = 's4g7fz1o6mmn60l'
    Dropbox::API::Config.mode       = "sandbox"
    
    client = Dropbox::API::Client.new(:token  => '9qfxnpa3swd080od', :secret => 'f4emrr6qhlr2ob6')
    config   = Rails.configuration.database_configuration
    path = Rails.root.join(config[Rails.env]["database"])
    client.upload 'clone.db' , File.read(path)
  end
end
