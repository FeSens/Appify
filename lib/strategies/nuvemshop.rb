require 'omniauth-oauth2'

module Strategies
  class Nuvemshop < OmniAuth::Strategies::OAuth2
    SHOP_TOKEN = "https://www.nuvemshop.com.br/apps/authorize/token"

    option :client_options, {
      site: "https://www.nuvemshop.com.br",
      token_url: 'apps/authorize/token',
      connection_build: lambda { |builder|
        builder.request :url_encoded
        builder.response :json
        builder.adapter Faraday.default_adapter
       },
      raise_errors: false,
    }
    
    option :auth_token_params, { parse: :json } 
  end
end