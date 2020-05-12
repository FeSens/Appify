Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :homepage, only: %i[show]
  resources :manifest_forms
  resources :manifest, only: %i[index]
  resources :home
  resources :privacy, only: %i[index]
  resources :render_js, only: %i[index], path: '/preferences'
end
