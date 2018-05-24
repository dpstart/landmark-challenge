class ProfilesController < ApplicationController

    def new
        @profile = Profile.new       
    end

    def create
        if @profile.save
            render :json => 'success'
        else
            render :json => 'error'
        end
    end
end
