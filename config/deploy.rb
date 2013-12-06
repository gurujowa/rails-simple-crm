set :application, "rails-simple-crm"
set :repo_url,  "https://github.com/gurujowa/rails-simple-crm.git"
set :scm, :git
set :branch, 'master'
set :deploy_to, '/var/www/rails-crm'
set :keep_releases, 10
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system config/shared}
set :username, 'yamashita'

#rbenv ‚Ìİ’è
set :rbenv_type, :user
set :rbenv_ruby, '2.0.0-p353'
set :rbenv_path, "/home/#{fetch(:username)}/.rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :ssh_options, :port => "10234"

#bunlde ‚Ìİ’è
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
set :bundle_bins, %w(gem rake rails)

#wheneber‚Ìİ’è
#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

#after 'deploy', 'deploy:symlink_shared'
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

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :mkdir, '-p', release_path.join('tmp') # <= ‚±‚ê‚ğ’Ç‰Á‚·‚é
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
