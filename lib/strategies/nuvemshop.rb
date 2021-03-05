require 'omniauth-oauth2'

module Strategies
  class Nuvemshop < OmniAuth::Strategies::OAuth2
    SHOP_TOKEN = "https://www.nuvemshop.com.br/apps/authorize/token"

    option :client_options, {
      site: "https://www.nuvemshop.com.br",
      token_url: 'apps/authorize/token',
      raise_errors: false
    }
    
    option :token_params, { parse: :json } 

    uid { raw_info['user_id'] }

    info do
      {
        scope: raw_info['scope'],
        token_type: raw_info['token_type'],
        access_token: raw_info['access_token'],
        user_id: raw_info['user_id']
      }
    end

    def raw_info
      @raw_info ||= access_token.params
    end
  end
end