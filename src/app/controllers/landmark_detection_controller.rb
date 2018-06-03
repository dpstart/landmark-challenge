class LandmarkDetectionController < ApplicationController
    # project_id = "Your Google Cloud project ID"
    # image_path = "Path to local image file, eg. './image.png'"

    require "google/cloud/vision"
    require "open-uri"
    def detection
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
        create_visit(@landmark_name, @landmark_latitude, @landmark_longitude,current_user.id)
    end
    private
    def save_image
        File.open("landmark.jpg",'wb') do |f|
            f.write params[:image].read
        end
    end

    def create_visit(name, lat, long, user_id)
        landmark_id = Landmark.find_by(:name => name).id
        profile_id = Profile.find_by(:user_id => user_id).id
        @hasvisited = HasVisited.new(:landmark_id => landmark_id, :profile_id => profile_id)
        if @hasvisited.save
            render :json => { :status => 'success', :hasvisited => @hasvisited}, status: 200
        else
            render :json => { :status => 'error', :message => @hasvisited.errors.details}, status: 401
        end
    end

end
