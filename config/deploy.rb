set :application, "rails-simple-crm"
set :repo_url,  "https://github.com/gurujowa/rails-simple-crm.git"
set :scm, :git
set :branch, 'master'
set :deploy_to, '/var/www/rails-crm'
set :keep_releases, 10
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system config/shared}
set :username, 'yamashita'
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

#rbenv ‚Ìİ’è
set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_path, "/home/#{fetch(:username)}/.rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :ssh_options, :port => "10234"


#wheneber‚Ìİ’è
#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

after 'deploy', 'deploy:restart'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }


# set :format, :pretty
# set :log_level, :debug
# set :pty, true

task :whenever do
  on roles(:all) do |h|
    execute "cd " + release_path.to_s + " &&  bundle exec whenever | crontab"
  end
end

namespace :deploy do

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "apachectl graceful"
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
