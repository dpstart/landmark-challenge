class ProfilesController < ApplicationController

    before_action :authenticate_user!, only: [:edit]

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

    def edit
        profile = Profile.find_by(:user_id => current_user.id)
        if params[:first_name] != nil
            profile.first_name = params[:first_name]
        end        
        if params[:last_name] != nil
            profile.last_name = params[:last_name]
        end        
        if params[:bio] != nil
            profile.bio = params[:bio]
        end
        #if params[:reputation] != nil
        #    profile.reputation = params[:reputation]
        #end    
        if profile.save 
            render :json => { :status => 'success', :message => 'Profile edited successfully'}, status: 201
        else
            render :json => { :status => 'error', :message => 'Profile not edited'}, status: 400
        end    
    end

    def delete_account
        email = params[:email]
        user = User.find_by(:email => email)
        user_id = user.id
        profile = Profile.find_by(:user_id => user_id)
        if profile.destroy && user.destroy
            render :json => { :status => 'success', :message => 'Account deleted' }, status: 201
        else
            render :json => { :status => 'error', :message => 'Account not found or not deleted' }, status: 400
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
        render :json => { :status => 'success', :goals => @goals}, status: 201
    end

    def achievements
        @has_earned = HasEarned.where(:profile_id => profile_id).to_a
        res = []
        @has_earned.each do |earned|
            achievement= Achievement.find_by(:id => earned.achievement_id)
            res << achievement
        end 
        render :json => { :status => 'success', :achievements => res}, status: 201
    end

    def reputation
        profile = Profile.find_by(:user_id => current_user.id)
        render :json => { :status => 'success', :reputation => profile.reputation}, status: 201
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
