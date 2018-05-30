class LandmarkDetectionController < ApplicationController
    # project_id = "Your Google Cloud project ID"
    # image_path = "Path to local image file, eg. './image.png'"

    require "google/cloud/vision"
    require "open-uri"
    def detection
        safe_image()
        vision = Google::Cloud::Vision.new project: "landmark_project_204915"
        image  = vision.image "landmark.jpg"

        image.landmarks.each do |landmark|
          puts landmark.description
        
          landmark.locations.each do |location|
            puts "#{location.latitude}, #{location.longitude}"
          end
        end
    end
    private
    def save_image
        File.open("landmark.jpg",'wb') do |f|
            f.write params[:image].read
        end
    end

end
