Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => 'admin/home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :privacy, only: %i[index]

  namespace :admin do
    resources :home
    resources :campaigns
    resource :pwa, only: %i[edit update]
    resources :subscribers, only: %i[index]
    resources :optins, only: %i[index update]
    resource :locales, only: %i[update]
    resources :integrations
    resources :installation
    resource :marketing_values, only: %i[edit update]
    resources :plans, only: %i[index create callback] do
      collection do
        get :callback
      end
    end
  end

  namespace :analytics do
    resources :campaigns, only: %i[create]
    resources :subscribers, only: %i[create]
    resources :page_visits, only: %i[create]
    resources :carts, only: %i[create]
    resources :opt_ins, only: %i[create]
  end

  namespace :public do
    resources :js, only: %i[index show], path: '/preferences'
    resources :manifest, only: %i[index show]
    resource :push, only: %i[create]
  end

  namespace :api do
    namespace :v1 do
      namespace :webhook do
        resource :push, only: %i[create]
      end
      resources :webhook, only: %i[index create]
    end
  end

  controller :mandatory_webhooks do
    post '/webhooks/shop_redact' => :shop_redact
    post '/webhooks/customers_redact' => :customers_redact
    post '/webhooks/customers_data_request' => :customers_data_request
  end

  controller :auth_faliure do
    get '/auth/failure' => :index
  end

  require "sidekiq/web"
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest("admin")) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest("jrqwknclqjpcniqiwuhnberuyb"))
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"


  flipper_app = Flipper::UI.app(Flipper.instance) do |builder|
    builder.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest("admin")) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest("jrqwknclqjpcniqiwuhnberuyb"))
    end
  end
  mount flipper_app, at: '/flipper'
end
