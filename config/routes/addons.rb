require "sidekiq/web"
constraints subdomain: /(www)|(app)/ do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount ShopifyApp::Engine, at: '/'

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
  
  controller :mandatory_webhooks do
    post '/webhooks/shop_redact' => :shop_redact
    post '/webhooks/customers_redact' => :customers_redact
    post '/webhooks/customers_data_request' => :customers_data_request
  end
  
  controller :auth_faliure do
    get '/auth/failure' => :index
  end
end
