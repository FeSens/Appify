module NuvemshopAPI
  class Session 
    attr_accessor :store_id, :token

    class << self
      def setup(params)
        params.each { |k, value| public_send("#{k}=", value) }
      end

      def temp(store_id:, token:, &block)
        session = new(store_id: store_id, token: token)
      
        with_session(session, &block)
      end
      
      def with_session(session, &_block)
        begin
          NuvemshopAPI::Base.clear_session
          NuvemshopAPI::Base.activate_session(session)
          yield
        end
      end
    end

    def initialize(store_id:, token:)
      self.token = token
      self.store_id = store_id
    end

    def site
      "https://api.nuvemshop.com.br/v1/#{store_id}/"
    end
  end
end