module NuvemshopAPI
  class Base < ::ActiveResource::Base
    self.include_format_in_path = false
    self.headers['Authentication'] = 'bearer fa57087f9031185562d0ded379d7e93f98b20ebe'
    self.headers['User-Agent'] = 'Vorta (felipesensbonetto@gmail.com)'
    self.headers['Content-Type'] = 'application/json'

    class << self
      def activate_session(session)
        raise InvalidSessionError, "Session cannot be nil" if session.nil?
        self.site = session.site
        self.headers.merge!('Authentication' => "bearer #{session.token}")
      end

      def clear_session
        self.site = nil
        self.headers.delete('Authentication')
      end
    end
  end
end