class ProfilesController < ApplicationController

    before_action :authenticate_user!, only: [:index]

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

    def goals
        @achievements = Achievement.all.to_a
        p @achievements
        @has_earned = HasEarned.where(:profile_id => profile_id).to_a
        p @has_earned
        res = []
        @has_earned.each do |has_earned|
            res << has_earned.achievement
        end
        @goals = @achievements - res
        render :json => @goals
    end

    def achievements
        @has_earned = HasEarned.where(:profile_id => profile_id).to_a
        res = []
        @has_earned.each do |achievement|
            res << achievement
        end 
        render :json => res
    end

    private
        def profile_id 
            @user_id = User.find_by(:email => params[:email]).id
            @profile_id = Profile.find_by(:user_id => @user_id).id
        end

        def failure(msg)
            render :json => { :status => "error", :message => msg }, status: 401
        end
end
