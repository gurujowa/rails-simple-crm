set :application, "rails-simple-crm"
set :user, "yamashita"
set :use_sudo, false
set :repository,  "https://github.com/gurujowa/rails-simple-crm.git"
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names


role :app, "192.168.1.145"
set :deploy_to, "/var/www/html/rails-crm/"
#role :app, "192.168.1.145"
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run


task :db_setup, :roles => [:db] do
  run "mkdir -p -m 775 #{shared_path}/db"
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
 end
