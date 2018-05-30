class LandmarksController < ApplicationController

    before_action :authenticate_admin!, only: [:create, :destroy]

    # If 'name' param is set, a query is made to filter landmarks located in that city
    # Else all landmarks are rendered
    def index
        if params[:city]
            @landmarks = Landmark.all
            @city_name = params['city']
            @city = City.find_by(:name => @city_name)
            if @city 
                @city_id = @city.id
                render :json => @landmarks.where(:city_id => @city_id), status: 200
            else
                render :json => { :status => 'error', :message => 'No such city in the database' }, status: 401
            end
        else
            @landmarks = Landmark.all
            render :json => @landmarks
        end
    end

    def create
        @landmark = Landmark.new(landmark_params)
        if @landmark.save
            render :json => { :status => 'landmark_created', :landmark_id => @landmark.id, :city_id => @landmark.city_id }, status: 200
        else
            render :json =>  { :status => 'error', :message => @landmark.errors.details }, status: 400
        end
    end

    def destroy
        if Landmark.find_by(:name => params[:name]).destroy
            render :json => { :status => "success", :message => "Landmark destroyed"}, status:201
        else
            render :json => { :status => "error", :message => "Landmark not destroyed"}, status:401
        end
    end

    def destroy
        # Only admins should be able to delete Landmarks
        if Landmark.find_by(:name => params[:name]).destroy
            render :json => { :status => "success", message => "Landmark destroyed" }, status: 201
        else
            render :json => { :status => "error", message => "Cannot destroy landmark. Are you sure it exists and you're an admin? ;)" }, status: 401
        end
    end

    private

        def landmark_params
            params.require(:landmark).permit(:name, :description, :latitude, :longitude, :city_id)
        end
    
end
