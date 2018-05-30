require 'colorize'

class CustomOmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

  def omniauth_success
      get_resource_from_auth_hash
      set_token_on_resource
      create_auth_params

      logger.info '[INFO]'.blue + ' ' + 'Auth success!'

      if confirmable_enabled?
        # don't send confirmation email!!!
        @resource.skip_confirmation!
      end

      sign_in(:user, @resource, store: false, bypass: false)

      begin
        @resource.save
      rescue ActiveRecord::RecordNotUnique
        # render :json => { :status => 'error', :message => 'Error in saving to database! Perhaps you previously signed up with this email? ;)' }
        redirect_to 'http://localhost:3000/#/error/?' + 'message=' + 'error in saving to database! Perhaps you previously signed up with this email? ;)'
        return
      end
      
      name = @resource["name"]
      first_name = name.split(' ')[0]
      last_name = name.split(' ')[1]      
      @resource.profile = Profile.new(:first_name => first_name, :last_name => last_name)
      @resource.save

      yield @resource if block_given?

      logger.info '[INFO]'.blue + ' ' + @auth_params.to_s

      # render :json => @auth_params
      redirect_to 'http://localhost:3000/#/auth_token?' + 
                                                         + 'token=' + @auth_params[:auth_token] +
                                                         + '&uid=' + @auth_params[:uid] +
                                                         + '&client_id=' + @auth_params[:client_id]
  end

end
