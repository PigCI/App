class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked
  retry_on Octokit::InternalServerError, wait: :exponentially_longer, attempts: 5
  retry_on Octokit::BadGateway, wait: :exponentially_longer, attempts: 5

  # Most jobs are safe to ignore if the underlying records are no longer available
  discard_on ActiveJob::DeserializationError
end
