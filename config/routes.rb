Rails.application.routes.draw do
  # Have a path just for checking uptime, a no frills things to just check we're alive
  get :uptime_check, path: 'uptime-check', to: proc { [200, {}, ["Hello Robot - We're still up"]] }

  constraints subdomain: 'api' do
    namespace :api do
      namespace :v1 do
        resources :reports, only: [:create], defaults: { formats: :json }
      end
    end
    get '/', to: redirect("https://#{ENV['URL']}/api")
  end

  constraints subdomain: 'webhooks' do
    namespace :webhooks do
      resources :github, only: [:create], defaults: { formats: :json }
    end
    get '/', to: redirect("https://#{ENV['URL']}")
  end

  constraints subdomain: ['', 'www'] do
    devise_for :users,
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 sign_up: 'join-us'
               }, controllers: {
                 sessions: 'users/sessions',
                 omniauth_callbacks: 'users/omniauth_callbacks'
               }

    namespace :setup do
      resource :github, only: [:show]
    end

    resource :billing, only: [:show]
    resource :settings, only: [:show]

    resources :projects do
      member do
        get :delete
        get :setup
      end
      resources :report_collections, only: [:show] do
        resources :reports, only: [:show]
      end
    end

    get 'api', to: 'landing#api'
    get 'contact-us', to: 'landing#contact_us'
    get 'roadmap', to: 'landing#roadmap'

    get 'privacy-policy', to: 'legals#privacy_policy'
    get 'terms-of-service', to: 'legals#terms_of_service'
    get 'cookie-policy', to: 'legals#cookie_policy'
    get 'subprocessors', to: 'legals#subprocessors'
    get 'github-integration-deprecation-notice', to: 'legals#github_integration_deprecation_notice'

    get '', to: 'landing#index'
  end

  if Rails.env.development?
    constraints subdomain: 'style' do
      mount MountainView::Engine => '/'
    end
  end

  root to: redirect("https://#{ENV['URL']}")
end
