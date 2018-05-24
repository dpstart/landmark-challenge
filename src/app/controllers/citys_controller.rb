class CitysController < ApplicationController

    before_action :authenticate_admin!, only: [:create]

    def index
        @cities = City.all
        render :json => @cities
    end
    
    def create
        @city = City.new(city_params)
        if @city.save
            render :json => @city
        else
            render :json => 'error'
        end
    end

    def find_id_by_name
        @city = City.find_by(name: params[:name])

        if @city
            render :json => { :status => 'success', :city_id => @city[:id] }, status: 200
        else 
            render :json => { :status => 'error', :message => 'City not found' }, status: 400
        end
    end

    private
        def city_params
            params.require(:city).permit(:name, :country)
        end
end
