class RestaurantsController < ApplicationController
    before_action :find_restaurant, only: [:show]
    before_action :set_new_restaurant

    def index
        @restaurants = Restaurant.all
    end
    
    def show
        @reviews = @restaurant.reviews
        @new_review = Review.new
    end
    
    def create
        @restaurant = Restaurant.new(restaurant_params)
        
        if @restaurant.save
            render json: { success: true, id: @restaurant.id}
            # redirect_to restaurant_path(@restaurant, anchor: "restaurant-#{@restarant.id}")
        else
            render json: { errors: @restaurant.errors }, status: :unprocessable_entity 
        end
    end

    private

    def find_restaurant
        @restaurant = Restaurant.find(params[:id])
    end

    def set_new_restaurant
        @new_restaurant = Restaurant.new
    end

    def restaurant_params
        params.require(:restaurant).permit(:name, :address, :phone_number, :category)
    end
end