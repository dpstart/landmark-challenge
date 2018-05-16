require 'colorize'

class RegistrationsController < Devise::RegistrationsController

	clear_respond_to
	respond_to :json

	def new
		log_info("RegistrationsController > `new` action invoked")
		super
	end

	def create
		log_info("RegistrationsController > `create` action invoked")

		user = User.new(user_params)
    	if user.save
      		render :json => {:auth_token => user.id}
      		return
    	else
      		warden.custom_failure!
      		render :json => user.errors, :status=>422
    	end
	end

	private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

		def log_error(errmsg)
			logger.error '[ERROR]'.red + ' ' + errmsg
		end

		def log_info(msg)
			logger.info '[INFO]'.blue + ' ' + msg
		end

end
