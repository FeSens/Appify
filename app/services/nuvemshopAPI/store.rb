module NuvemshopAPI
  class Store < Base
    include ActiveResource::Singleton

    def current(options = {})
      find(options)
    end
  end
end