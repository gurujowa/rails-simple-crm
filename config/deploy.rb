
set :application, "rails-simple-crm"
set :repo_url,  "https://github.com/gurujowa/rails-simple-crm.git"
set :scm, :git
set :branch, 'master'
set :deploy_to, '/var/www/html/rails-crm2'
set :git_https_username, "gurujowa"
set :git_https_password, "ma3gbuib"
set :keep_releases, 2
#set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :default_env, { path: "/opt/ruby/bin:$PATH" }

#set :normalize_asset_timestamps, false
#set :user, "yamashita"
#set :use_sudo, false


#wheneber‚ÌÝ’è
#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

#after 'deploy', 'deploy:symlink_shared'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }


# set :format, :pretty
# set :log_level, :debug
# set :pty, true

#task :db_setup, :roles => [:db] do
#  run "mkdir -p -m 775 #{shared_path}/db"
#end


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :mkdir, '-p', release_path.join('tmp') # <= ‚±‚ê‚ð’Ç‰Á‚·‚é
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/shared_config/ #{release_path}/shared"
  end

  after :finishing, 'deploy:cleanup'

end
