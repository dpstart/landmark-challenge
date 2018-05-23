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
		user.profile = Profile.new(profile_params)

		if user.profile.save
			log_info('RegistrationsController >>> Successfully created user\'s profile with id=' + user.profile.id.to_s)
		else
			log_error('RegistrationsController >>> Error creating user\'s profile')
		end

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
			param = params.permit(:email, :password, :password_confirmation, :first_name, :last_name).except(:first_name, :last_name)
		end

		def profile_params
			params.permit(:first_name, :last_name).except(:email, :password, :password_confirmation)
		end

		def log_error(errmsg)
			logger.error '[ERROR]'.red + ' ' + errmsg
		end

		def log_info(msg)
			logger.info '[INFO]'.blue + ' ' + msg
		end

end
