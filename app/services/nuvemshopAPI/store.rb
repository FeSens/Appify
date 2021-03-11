module NuvemshopAPI
  class Store < Base
    include ActiveResource::Singleton

    class << self
      def current(options = {})
        find(options)
      end
    end
  end
end