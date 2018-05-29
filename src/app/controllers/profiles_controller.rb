class ProfilesController < ApplicationController

    # Only admins should be able to use this action
    def all

    end

    def index
        @email = params[:email]
        if @email
            @user_id = User.find_by(:email => @email)
            if @user_id
                # FIXME: OAuth signed-up users don't have a profile
                render :json => Profile.find_by(:user_id => @user_id)
            else
                failure("email not found")
            end
        else
            failure("email must be provided as parameter")
        end
    end

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

    private
        def failure(msg)
            render :json => { :status => "error", :message => msg }, status: 401
        end
end
