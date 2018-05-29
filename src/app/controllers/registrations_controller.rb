require 'colorize'

class RegistrationsController < DeviseTokenAuth::RegistrationsController

	clear_respond_to
	respond_to :json

	
	def create
		build_resource
  
		unless @resource.present?
		  raise DeviseTokenAuth::Errors::NoResourceDefinedError,
			"#{self.class.name} #build_resource does not define @resource, execution stopped"
		end
  
		# give redirect value from params priority
		@redirect_url = params.fetch(
		  :confirm_success_url,
		  DeviseTokenAuth.default_confirm_success_url
		)
  
		# success redirect url is required
		if confirmable_enabled? && !@redirect_url
		  return render_create_error_missing_confirm_success_url
		end
  
		# if whitelist is set, validate redirect_url against whitelist
		return render_create_error_redirect_url_not_allowed if blacklisted_redirect_url?
  
		begin
		  # override email confirmation, must be sent manually from ctrl
		  resource_class.set_callback("create", :after, :send_on_create_confirmation_instructions)
		  resource_class.skip_callback("create", :after, :send_on_create_confirmation_instructions)
  
		  if @resource.respond_to? :skip_confirmation_notification!
			# Fix duplicate e-mails by disabling Devise confirmation e-mail
			@resource.skip_confirmation_notification!
		  end
  
		  @resource.profile = Profile.new(profile_params)

		  if @resource.save
			yield @resource if block_given?
  
			unless @resource.confirmed?
			  # user will require email authentication
			  @resource.send_confirmation_instructions({
				client_config: params[:config_name],
				redirect_url: @redirect_url
			  })
			else
			  # email auth has been bypassed, authenticate user
			  @client_id, @token = @resource.create_token
			  @resource.save!
			  update_auth_header
			end
			render_create_success
		  else
			clean_up_passwords @resource
			render_create_error
		  end
		rescue ActiveRecord::RecordNotUnique
		  clean_up_passwords @resource
		  render_create_error_email_already_exists
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
		def build_resource
			@resource            = resource_class.new(sign_up_params)
			@resource.provider   = provider
	  
			# honor devise configuration for case_insensitive_keys
			if resource_class.case_insensitive_keys.include?(:email)
			  @resource.email = sign_up_params[:email].try(:downcase)
			else
			  @resource.email = sign_up_params[:email]
			end
		 end
		  
		def blacklisted_redirect_url?
			DeviseTokenAuth.redirect_whitelist && !DeviseTokenAuth::Url.whitelisted?(@redirect_url)
	  	end
end
