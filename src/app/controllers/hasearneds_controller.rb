class HasearnedsController < ApplicationController
    require "date"
    def index
        @hasearneds = HasEarned.all
        render :json => @hasearneds
    end

    def show
        @hasearned = HasEarned.find_by(params[:id])
        render :json => @hasearned
    end

    def create
        @achievement_id = Achievement.find_by(:id => params[:achievement_id]).id
        @profile_id = Profile.find_by(:id => params[:profile_id]).id
        @date = DateTime.now
        @hasearned = HasEarned.new(:achievement_id => @achievement_id, :profile_id => @profile_id, :date => @date)
        if @hasearned.save
            render :json => { :status => 'success', :hasearned => @hasearned}, status: 200
        else
            render :json => { :status => 'error', :message => @hasearned.errors.details}, status: 401
        end
    end

    def destroy
        if HasEarned.find_by(:id => params[:id]).destroy
            render :json => { :status => 'success', :message => 'HasEarned relation destroyed' }, status: 200
        else
            render :json => { :status => 'error', :message => 'HasEarned relation not destroyed' }, status: 400
        end
    end

end
