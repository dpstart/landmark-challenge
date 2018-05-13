class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		logger.info ">> Successfully created new user"
		@user.save
	end

	private
		def user_params
			params.require(:user).permit(:email, :password)	
		end

end
