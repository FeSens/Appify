Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :homepage, only: %i[show]
  resources :manifest_forms
  resources :configuration_forms
  resources :manifest, only: %i[index]
  resources :home
  resources :campaigns
  resources :optins, only: %i[index update]
  resources :privacy, only: %i[index]
  resources :render_js, only: %i[index], path: '/preferences'

  namespace :analytics do
    resources :campaigns, only: %i[create]
  end

  namespace :public do
    resources :modals, only: %i[index]
  end

  controller :mandatory_webhooks do
    post '/webhooks/shop_redact' => :shop_redact
    post '/webhooks/customers_redact' => :customers_redact
    post '/webhooks/customers_data_request' => :customers_data_request
  end

  resource :push, only: %i[create]
  resource :send_push, only: %i[create]

  resources :subscriber_count, only: %i[create index]

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
end
