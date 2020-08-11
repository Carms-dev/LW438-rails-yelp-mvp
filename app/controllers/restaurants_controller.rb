class RestaurantsController < ApplicationController
    before_action :find_restaurant, only: [:show]


    def index
        @restaurants = Restaurant.all.reverse
        
        if params[:search].present? 
            sql_query = "\
                restaurants.name LIKE :query \
                OR restaurants.address LIKE :query \
                OR restaurants.phone_number LIKE :query \
                OR restaurants.category LIKE :query \
            "            
            @restaurants = Restaurant.where(sql_query, query: "%#{params[:search]}%")
            @keyword = params[:search]
        end
    end
    
    def show
        @reviews = @restaurant.reviews
        @new_review = Review.new
    end
    
    def create
        restaurant = Restaurant.new(restaurant_params)
        
        if restaurant.save
            render json: restaurant
        else
            render json: { errors: restaurant.errors }, status: :unprocessable_entity # HTML 422
        end
    end

    private

    def find_restaurant
        @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
        params.require(:restaurant).permit(:name, :address, :phone_number, :category)
    end
end