Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :homepage, only: %i[show]
  resources :manifest_forms
  resources :configuration_forms
  resources :manifest, only: %i[index]
  resources :home
  resources :privacy, only: %i[index]
  resources :render_js, only: %i[index], path: '/preferences'

  controller :mandatory_webhooks do
    post '/webhooks/shop_redact' => :shop_redact
    post '/webhooks/customers_redact' => :customers_redact
    post '/webhooks/customers_data_request' => :customers_data_request
  end

  resource :push, only: %i[create]
  resource :send_push, only: %i[create]

  resources :subscriber_count, only: %i[create index]
end
