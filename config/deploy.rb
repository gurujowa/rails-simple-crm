set :application, "rails-simple-crm"
set :normalize_asset_timestamps, false
set :user, "yamashita"
set :use_sudo, false
set :repository,  "https://github.com/gurujowa/rails-simple-crm.git"
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
set :deploy_to, "/var/www/html/rails-crm/"

role :app, "192.168.1.145"
role :db, "192.168.1.145", :primary => true

#wheneberの設定
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

after 'deploy', 'deploy:symlink_shared'


namespace :db do
  task :setup, :roles => [:db] do
    run "mkdir -p -m 775 #{shared_path}/db"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
#after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/shared_config/ #{release_path}/shared"
  end
end
