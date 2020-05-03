# From: https://www.driftingruby.com/episodes/periodic-tasks-with-sidekiq-cron
Sidekiq.configure_server do |_config|
  schedule_file = Rails.root.join('config', 'schedule.yml')

  # Use https://crontab.guru to confirm times
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if schedule_file.exist?
end

Sidekiq.configure_client do |_config|
  # Any client specific configuration
end
