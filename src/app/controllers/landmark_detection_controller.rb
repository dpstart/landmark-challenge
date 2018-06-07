class LandmarkDetectionController < ApplicationController
    
    # before_action :authenticate_user!, only: [:detection]

    require "google/cloud/vision"
    require "open-uri"
    def detection
        p request.headers[:uid]
        user = User.find_by(:uid => request.headers[:uid])
        save_image()
        vision = Google::Cloud::Vision.new project: "landmark_project_204915", keyfile: "landmark-challenge-4f26e0aeca60.json"
        image  = vision.image "landmark.jpg"

        image.landmarks.each do |landmark|
          @landmark_name = landmark.description
        
          landmark.locations.each do |location|
            @landmark_latitude = location.latitude 
            @landmark_longitude = location.longitude
          end
        end
        create_visit(@landmark_name, @landmark_latitude, @landmark_longitude,user.id)
    end
    private
    def save_image
        File.open("landmark.jpg",'wb') do |f|
            f.write params[:file].read
        end
    end

    def create_visit(name, lat, long, user_id)
        landmark = Landmark.find_by(:name => name)
        if landmark == nil 
            render :json => { :status => 'error', :message => name + " in not in our list of landmarks"}, status: 400
            return
        end
        landmark_id = landmark.id
        profile_id = Profile.find_by(:user_id => user_id).id
        if HasVisited.where(:profile_id => profile_id, :landmark_id => landmark_id) 
            render :json => { :status => 'error', :message => "You have already visited " + name }, status: 200
            return
        end
        @hasvisited = HasVisited.new(:landmark_id => landmark_id, :profile_id => profile_id)
        if @hasvisited.save
            render :json => { :status => 'success', :hasvisited => @hasvisited, :landmark => landmark}, status: 200
        else
            render :json => { :status => 'error', :message => @hasvisited.errors.details}, status: 400
        end
    end

end
