Rails.application.default_url_options = {
  host: ENV.fetch('URL', 'pigciapp.test'),
  protocol: 'https'
}
