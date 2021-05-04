Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'admin/home#index'

  resources :privacy, only: %i[index]
  resource :demo_page, only: %i[show]

  namespace :admin do
    resources :home
    resources :campaigns
    resources :automations
    resources :flow_charts
    resource :pwa, only: %i[edit update]
    resources :subscribers, only: %i[index]
    resources :optins, only: %i[index update]
    resource :locales, only: %i[update]
    resources :integrations
    resources :installation
    resource :marketing_values, only: %i[edit update]
    resources :settings, only: %i[index]
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
    resource :push, only: %i[create new]
    resources :checkouts, only: %i[create]

  end

  namespace :api do
    namespace :v1 do
      namespace :webhook do
        resource :push, only: %i[create]
      end
      resources :webhook, only: %i[index create]
    end
  end

  Appify::Application.routes.draw do
    draw :sublinks
    draw :addons
  end
end
