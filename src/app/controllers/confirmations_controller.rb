class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
    def show
      @resource = resource_class.confirm_by_token(params[:confirmation_token])

      @redirect_url = 'http://localhost:3000'

      if @resource 
        redirect_to(@redirect_url)
      else
        raise ActionController::RoutingError.new('Not Found')
      end
  	end
end