module Demo
  class DemoController < ActionController::Base
    layout "demo"
    helper_method :current_shop

    def current_shop
      @current_shop ||= Shop.last
    end
  end
end
