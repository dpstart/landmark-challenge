class HasvisitedsController < ApplicationController
    def index
        @hasvisiteds = HasVisited.all
        render :json => @hasvisiteds
    end

    def show
        @hasvisited = HasVisited.find_by(params[:id])
        render :json => @hasvisited
    end

    def create
        @landmark_id = Landmark.find_by(:id => params[:landmark_id]).id
        @profile_id = Profile.find_by(:id => params[:profile_id]).id
        @hasvisited = HasVisited.new(:landmark_id => @landmark_id, :profile_id => @profile_id)
        if @hasvisited.save
            render :json => { :status => 'success', :hasvisited => @hasvisited}, status: 200
        else
            render :json => { :status => 'error', :message => @hasvisited.errors.details}, status: 401
        end
    end

    def destroy
        if HasVisited.find_by(:id => params[:id]).destroy
            render :json => { :status => 'success', :message => 'HasVisited relation destroyed' }, status: 200
        else
            render :json => { :status => 'error', :message => 'HasVisited relation not destroyed' }, status: 400
        end
    end
end
