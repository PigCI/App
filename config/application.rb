require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PigCIApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Enable serving of images, stylesheets, and JavaScripts from an asset server.
    if ENV['ASSET_HOST']
      config.action_controller.asset_host = ENV['ASSET_HOST']
      config.action_mailer.asset_host = ENV['ASSET_HOST']
    elsif ENV['HEROKU_APP_NAME'].present?
      config.action_controller.asset_host = "https://#{ENV['HEROKU_APP_NAME']}.herokuapp.com"
      config.action_mailer.asset_host = "https://#{ENV['HEROKU_APP_NAME']}.herokuapp.com"
    end

    # For previewing mailers in review environments.
    if ENV['ENABLE_MAILER_PREVIEWS'].present?
      config.action_mailer.show_previews = true
      config.action_mailer.preview_path ||= defined?(Rails.root) ? "#{Rails.root}/spec/mailers/previews" : nil
    end

    # Set default URL options for _url
    config.action_controller.default_url_options = {
      host: ENV.fetch('URL', 'pigciapp.test'),
      protocol: 'https'
    }

    # I18n
    config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.{rb,yml}"]
    config.i18n.fallbacks = true

    # Generators
    config.generators do |g|
      g.helper false
      g.assets false
      g.helper false
      g.view_specs false
      g.decorator false
      g.system_tests false
    end

    # Workers
    if ENV['REDIS_URL'].present?
      config.cache_store = :redis_cache_store, {
        url: ENV['REDIS_URL'],
        network_timeout: 5
      }
      config.active_job.queue_adapter = :sidekiq
    else
      config.active_job.queue_adapter = :inline
    end

    # Static caching improvements
    config.static_cache_control = 'public, max-age=31536000'
  end
end
