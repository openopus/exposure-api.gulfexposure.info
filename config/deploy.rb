set :application, 'api.gulfexposure.info'
set :repo_url, 'git@git.opuslogica.com:EXPOSURE/api.gulfexposure.info'

# Default branch is the current one.
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to, '/www/sites/api.gulfexposure.info'
set :rails_env, 'production'
set :scm, :git
set :log_level, :info
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Slackistrano integration
set :slack_channel, ["#devops"]
set :slack_webhook, "https://hooks.slack.com/services/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"

namespace :deploy do
  task :linkup do
    on roles(:app) do
      within "#{release_path}/config" do
        %w(database secrets).each do |config_file|
          execute :rm, "-f", "#{config_file}.yml"
          execute :ln, "-s", "#{config_file}.yml-#{fetch(:stage).to_s}", "#{config_file}.yml"
        end
      end
    end
  end

  desc "Update crontab with whenever"
  task :update_cron do
    on roles(:app) do
      within current_path do
        execute :bundle, :exec, "whenever --update-crontab #{fetch(:application)}"
      end
    end
  end

  # after :finishing, 'deploy:update_cron'
end

before "deploy:assets:precompile", "deploy:linkup"


