module Public
  class ModalsController < PublicController
    def index
      @optin = shop.optins.find_by(kind: 'pwa')
      render partial: 'modal'
    end
  end
end
