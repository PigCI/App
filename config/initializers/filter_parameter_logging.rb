# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [
  :password,
  # Stripe
  :stripe_card_token, :stripe_publishable_key,
  # An API
  :access_token, :refresh_token,
  # Devise
  :confirmation_token
]
