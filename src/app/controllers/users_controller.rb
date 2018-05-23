require 'colorize'

class UsersController < ApplicationController

	before_action :authenticate_user!, except: [:create]

	def index
		log_info('UsersController >>> \'index\' action invoked')
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		@user.profile = Profile.new(profile_params)

		if @user.save
			log_info('UsersController >>> Successfully created new user with id=' + @user.id.to_s)
		else
			log_error('UsersController >>> Error creating new user')
		end

		if @user.profile.save
			log_info('UsersController >>> Successfully created user\'s profile with id=' + @user.profile.id.to_s)
		else
			log_error('UsersController >>> Error creating user\'s profile')
		end
	end

	def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			log_info('UsersController >>> Successfully updated user')
		else
			log_error('UsersController >>> Error updating user')
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
	end

	private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)	
		end

		def profile_params
			params.require(:profile).permit(:first_name, :last_name)
		end

		def log_error(errmsg)
			logger.error '[ERROR]'.red + ' ' + errmsg
		end

		def log_info(msg)
			logger.info '[INFO]'.blue + ' ' + msg
		end

end
