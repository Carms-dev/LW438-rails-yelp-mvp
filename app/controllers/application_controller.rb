class ApplicationController < ActionController::Base
    before_action :set_new_restaurant

    private

    # support navbar new restaurant modal
    def set_new_restaurant
        @new_restaurant = Restaurant.new
    end
end
