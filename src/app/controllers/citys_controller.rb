class CitysController < ApplicationController
    
    def create
        @city = City.new(city_params)
        if @city.save
            render :json => @city
        else
            render :json => 'error'
        end
    end

    private
        def city_params
            params.require(:city).permit(:name, :country)
        end
end
