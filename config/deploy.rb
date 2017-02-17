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
set :linked_dirs, fetch(:linked_dirs, []).push('node_modules')
set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)
set :sudo
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

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

    namespace :assets do
      Rake::Task['deploy:assets:precompile'].clear_actions

      desc "Precompile assets on local machine and upload them to the server."
      task :precompile do
        run_locally do
          execute 'RAILS_ENV=production bundle exec rake assets:precompile'
        end

        on roles(:web) do
          within release_path do
            asset_full_path = "#{release_path}/public/#{fetch(:assets_prefix)}"
            asset_parent_path = File.dirname(asset_full_path)
            execute "mkdir -p #{asset_full_path}"
            upload! "./public/#{fetch(:assets_prefix)}", asset_parent_path, recursive: true
          end
        end

        run_locally do
          execute "rm -r ./public/#{fetch(:assets_prefix)}"
        end
      end
    end

  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart

end

namespace :bundler do
  desc "Installing npm and browserify"
  task :install_npm do
    on roles(:app) do
      execute "echo 1qaz!QAZ | sudo -S  npm install"
      execute "echo 1qaz!QAZ | sudo -S  npm update --save"
    end
  end

  after :install, :install_npm
end


# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma