require 'colorize'

class RegistrationsController < Devise::RegistrationsController

	def new
		log_info("RegistrationsController > `new` action invoked")
		super
	end

	def create
		log_info("RegistrationsController > `create` action invoked")
		super
	end

	private

		def log_error(errmsg)
			logger.error '[ERROR]'.red + ' ' + errmsg
		end

		def log_info(msg)
			logger.info '[INFO]'.blue + ' ' + msg
		end

end
