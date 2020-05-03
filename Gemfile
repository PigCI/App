ruby File.read('.ruby-version').chomp

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

#  Allow .env to work everywhere.
gem 'dotenv-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# ActiveStorage
gem 'aws-sdk-s3'
gem 'image_processing', '~> 1.2'

# Workers
gem 'sidekiq'
gem 'sidekiq-cron'

# Assets
gem 'font_assets'

# Logs & monitoring
gem 'lograge'
gem 'sentry-raven'

# Cleaner views
gem 'croutons'
gem 'draper'
gem 'meta-tags'
gem 'model_attribute'
gem 'more_possessive'
gem 'mountain_view'
gem 'premailer-rails'
gem 'simple_form'

# Easy charts
gem 'chartkick'

# Code Sample Highlighting
gem 'rouge'

# Pagination
gem 'bootstrap4-kaminari-views'
gem 'kaminari'

# Devise
gem 'devise'
gem 'omniauth'
gem 'omniauth-github', git: 'https://github.com/omniauth/omniauth-github.git', ref: '967d769'

# Security and permissions
gem 'pundit'
# gem 'rack-attack'
gem 'valid_email2'

# I18n
gem 'http_accept_language'

# SEO
gem 'friendly_id' #, github: 'norman/friendly_id', branch: 'master'

# API Endpoints
gem 'octokit'

# Webhooks
gem 'jwt'
gem 'github_webhook', '~> 1.1'

# JSON Schema
gem 'json-schema'

# Slack Bot - Report Stats
gem 'slack-ruby-bot'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'launchy'

  gem 'capybara'
  gem 'capybara-email'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false

  gem 'faker'

  gem 'factory_bot_rails'
  gem 'vcr'
  gem 'webmock'

  gem 'webdrivers'

  gem 'rspec-rails', '~> 3.8'
  gem 'rspec_junit_formatter'
end

group :test do
  gem 'formulaic'
  gem 'pig-ci-rails', github: 'PigCi/pig-ci-rails', branch: 'master'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Open emails in the browser
  gem 'letter_opener'

  gem 'i18n-debug'
  # gem 'rack-mini-profiler'

  gem 'powder'
  gem 'puma-ngrok-tunnel'#, github: 'mikerogers0/puma-ngrok-tunnel', branch: 'master'
  gem 'rubocop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
