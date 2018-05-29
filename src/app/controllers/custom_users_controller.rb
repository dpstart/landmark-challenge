require 'colorize'

class CustomUsersController < ApplicationController

	def exists
		@user = User.find_by(email: params[:email])

		if @user
			logger.info '[INFO]'.blue + ' ' + 'User exists'
			render :json => { :success => true }
		else
			logger.info '[INFO]'.blue + ' ' + 'User does not exist'
			render :json => { :success => false }
		end

	end

end
