
set :application, "rails-simple-crm"
set :repo_url,  "https://github.com/gurujowa/rails-simple-crm.git"
set :scm, :git
set :branch, 'master'
set :deploy_to, '/var/www/html/rails-crm'
set :git_https_username, "gurujowa"
set :git_https_password, "ma3gbuib"
set :keep_releases, 10
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system config/shared}

#set :normalize_asset_timestamps, false


#wheneberÇÃê›íË
#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

#after 'deploy', 'deploy:symlink_shared'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }


# set :format, :pretty
# set :log_level, :debug
# set :pty, true

task :whenever do
  on roles(:all) do |h|
    execute "cd " + release_path.to_s + " &&  whenever | crontab"
  end
end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :mkdir, '-p', release_path.join('tmp') # <= Ç±ÇÍÇí«â¡Ç∑ÇÈ
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'

    end
  end

  after :finishing, 'deploy:cleanup'
  after :published, 'whenever'

end
