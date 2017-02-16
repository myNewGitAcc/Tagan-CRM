# Change these
server '104.131.169.1', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url, 'git@github.com:Scorpion626/Tagan-CRM.git'
set :application, 'Tagan-CRM'
set :user, 'vadim'
set :branch, 'Vadim'
set :puma_threads, [4, 16]
set :puma_workers, 0
# Don't change these unless you know what you're doing
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :ssh_options, {forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub)}
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord
set :linked_files, fetch(:linked_files, []).push('config/database.yml.example')
set :linked_dirs, %w(
  node_modules
)
## Defaults:
# set :scm,           :git

# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."

  desc 'Copy upstart script'
  task :upstart do
    on roles(:app) do
      within release_path do
        sudo :cp, "etc/#{fetch :application}.upstart.conf", "/etc/init/#{fetch :application}.conf"
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'pm2:restart'
    end
  end

  after :publishing, :restart

end

namespace :bundler do
  desc "Installing npm and browserify"
  task :install_npm do
    on roles(:app) do
      execute "npm --version"
      execute "echo 1qaz!QAZ | sudo -S npm install js-base64 --save"
      execute "echo 1qaz!QAZ | sudo -S  apt-get install nodejs-legacy"
      execute "echo 1qaz!QAZ | sudo -S  npm install babel-preset-es2015@6.9.0"
      execute "echo 1qaz!QAZ | sudo -S  npm install babelify@7.3.0"
      execute "echo 1qaz!QAZ | sudo -S  npm install bower@1.7.9"
      execute "echo 1qaz!QAZ | sudo -S  npm install browserify@10.2.6"
      execute "echo 1qaz!QAZ | sudo -S  npm install browserify-incremental@3.1.1"
      execute "echo 1qaz!QAZ | sudo -S npm init --yes \n"
      execute "echo 1qaz!QAZ | sudo -S  npm install underscore@1.8.3"
    end
  end

  after :install, :install_npm
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma