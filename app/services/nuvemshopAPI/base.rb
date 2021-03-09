module NuvemshopAPI
  class Base < ::ActiveResource::Base
    class InvalidSessionError < StandardError; end

    self.include_format_in_path = false
    self.headers['User-Agent'] = 'Vorta (felipesensbonetto@gmail.com)'
    self.headers['Content-Type'] = 'application/json'

    class << self
      threadsafe_attribute(:_api_version)
      def headers
        if _headers_defined?
          _headers
        elsif superclass != Object && superclass.headers
          superclass.headers
        else
          _headers ||= {}
        end
      end

      def activate_session(session)
        raise InvalidSessionError, "Session cannot be nil" if session.nil?
        self.site = session.site
        self.headers['Authentication'] = "bearer #{session.token}"
        print(self.headers)

      end

      def clear_session
        self.site = nil
        self.headers.delete('Authentication')
      end
    end
  end
end