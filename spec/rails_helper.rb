# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'
ENV['URL'] = 'www.example.com'
ENV['ASSET_HOST'] = nil

require 'simplecov'
SimpleCov.start 'rails' do
  # Ignore really small one line files for now.
  add_filter do |source_file|
    source_file.lines.count <= 2
  end
end

require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/email/rspec'
require 'webmock/rspec'
# require 'sidekiq/testing'
require 'vcr'
require 'faker'
require 'formulaic'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# Disable external connections - Mock them within the app.
WebMock.disable_net_connect!(allow_localhost: true)

require 'pig_ci'
PigCI.start do |config|
  # config.api_base_uri = ENV.fetch('PIG_CI_API_BASE_URL') { 'https://api.pigci.com/api' }
  # config.api_verify_ssl = !ENV['PIG_CI_API_SKIP_VERIFY_SSL'].present?
  config.api_key = ENV.fetch('PIG_CI_KEY') { 'IOIuMhZi_1e4fKSIqpuV5UxuChU3sBFftl-hPHS5vsc' }

  config.thresholds.memory = 500
  config.thresholds.request_time = 200
  config.thresholds.database_request = 52

  # config.generate_html_summary = false
  # config.generate_terminal_summary = false
end if RSpec.configuration.files_to_run.count > 1

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = false
  config.ignore_localhost = true
  config.ignore_hosts '127.0.0.1', 'localhost'
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.current_driver = :rack_test

Capybara.ignore_hidden_elements = false
