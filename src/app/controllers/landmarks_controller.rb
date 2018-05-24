class LandmarksController < ApplicationController

    before_action :authenticate_admin!, only: [:create]

    def index
        @landmarks = Landmark.all
        render :json => @landmarks
    end

    def create
        @landmark = Landmark.new(landmark_params)
        if @landmark.save
            render :json => 'success'
        else
            render :json => 'error'
        end
    end

    private

        def landmark_params
            params.require(:landmark).permit(:name, :description, :latitude, :longitude, :city_id)
        end
    
end
