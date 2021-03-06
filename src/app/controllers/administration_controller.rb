class AdministrationController < ApplicationController

	def stats
		@users_number = User.count
		@admins_number = Admin.count
		@landmarks_number = Landmark.count
		@cities_number = City.count
		@achievements_number = Achievement.count
		render :json => {
			:users => @users_number,
			:admins => @admins_number,
			:landmarks => @landmarks_number,
			:cities => @cities_number,
			:achievements => @achievements_number
		}, status: 200
	end

	def users
		render :json => User.all.to_a, status: 200
	end

	def admins
		render :json => Admin.all.to_a, status: 200
	end

	def landmarks
		render :json => Landmark.all.to_a, status: 200
	end

	def cities
		render :json => City.all.to_a, status: 200
	end

	def delete_user
		user_email = params[:user_email]
		user = User.find_by(:email => user_email)
		if user
			user.destroy
			render :json => { :status => "success", :message => "User successfully deleted" }, status: 200
		else
			render :json => { :status => "error", :message => "User doesn't exist" }, status: 401
		end
	end

	def new_admin
		admin_email = params[:email]
		admin_password = params[:password]
		if Admin.create(email: admin_email, password: admin_password, password_confirmation: admin_password)
			render :json => Admin.find_by(:email => admin_email), status: 200
		else
			render :json => { :status => "error", :message => "Error in creating new admin" }, status: 401
		end
	end

	def new_city
		city_name = params[:name]
		country = params[:country]
		if City.create(name: city_name, country: country)
			render :json => City.find_by(:name => city_name), status: 200
		else
			render :json => { :status => "error", :message => "Error in creating new city" }, status: 401
		end
	end

	def new_landmark
		landmark_name = params[:name]
		description = params[:description]
		latitude = params[:latitude]
		longitude = params[:longitude]
		city_name = params[:city]
		city = City.find_by(:name => city_name)
		if !city
			render :json => { :status => "error", :message => "City not found. Landmark not created" }, status: 401
		else 
			if Landmark.create(name: landmark_name, description: description, latitude: latitude, longitude: longitude, city_id: city.id)
				render :json => { :status => "success", :message => "Landmark created" }, status: 200
			else
				render :json => { :status => "error", :message => "Error in creating new landmark" }, status: 401
			end
		end
	end
end
