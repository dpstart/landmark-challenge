COLOSSEUM_DESCRIPTION = "Foobar"
BATHS_OF_CARACALLA_DESCRIPTION = "Do you want to take a bath here?"
MILAN_CATHEDRAL_DESCRIPTION = "I need a house in Milan"
BIG_BEN_DESCRIPTION = "The Big Bang Theory"
EIFFEL_TOWER_DESCRIPTION = "French people eat baguettes"
VAN_GOGH_MUSEUM_DESCRIPTION = "I need ears"
SAGRADA_FAMILIA_DESCRIPTION = "Ibiza selection on Radio Globo"

create_cities:
	echo 'City.create(:name => "Rome", :country => "Italy", :id => 0)' | rails c
	echo 'City.create(:name => "Milan", :country => "Italy", :id => 1)' | rails c
	echo 'City.create(:name => "London", :country => "United Kingdom", :id => 2)' | rails c
	echo 'City.create(:name => "Paris", :country => "France", :id => 3)' | rails c
	echo 'City.create(:name => "Amsterdam", :country => "Netherlands", :id => 4)' | rails c
	echo 'City.create(:name => "Barcellona", :country => "Spain", :id => 5)' | rails c
	
create_landmarks: create_cities
	echo 'Landmark.create(:description => ${COLOSSEUM_DESCRIPTION}, :name => "Colosseum", :latitude => 41.890251, :longitude => 12.492373, :city_id => 0, :id => 0)' | rails c
	echo 'Landmark.create(:description => ${BATHS_OF_CARACALLA_DESCRIPTION}, :name => "Baths of Caracalla", :latitude => 41.879444, :longitude => 12.492056, :city_id => 0, :id => 1)' | rails c
	echo 'Landmark.create(:description => ${MILAN_CATHEDRAL_DESCRIPTION}, :name => "Milan Cathedral", :latitude => 45.458536, :longitude => 9.187387, :city_id => 1, :id => 2)' | rails c
	echo 'Landmark.create(:description => ${BIG_BEN_DESCRIPTION}, :name => "Big Ben", :latitude => 51.500364, :longitude => -0.121432, :city_id => 2, :id => 3)' | rails c
	echo 'Landmark.create(:description => ${EIFFEL_TOWER_DESCRIPTION}, :name => "Eiffel Tower", :latitude => 48.8583, :longitude => 2.2945, :city_id => 3, :id => 4)' | rails c
	echo 'Landmark.create(:description => ${VAN_GOGH_MUSEUM_DESCRIPTION}, :name => "Van Gogh Museum", :latitude => 52.358415, :longitude => 4.881075, :city_id => 4, :id => 5)' | rails c
	echo 'Landmark.create(:description => ${SAGRADA_FAMILIA_DESCRIPTION}, :name => "Sagrada Familia", :latitude => 41.402165, :longitude => 2.171332, :city_id => 5, :id => 6)' | rails c

create_users:
	echo 'User.create(:email => "luca@gmail.com", :password => "passpass", :password_confirmation => "passpass", :id => 0)' | rails c
	echo 'User.create(:email => "daniele@gmail.com", :password => "passpass", :password_confirmation => "passpass", :id => 1)' | rails c
	
create_profiles:
	echo 'Profile.create(:first_name => "Luca", :last_name => "Ferrera", :user_id => 0,:id => 0)' | rails c
	echo 'Profile.create(:first_name => "Daniele", :last_name => "Cappuccio", :user_id => 1, :id => 1)' | rails c

create_achievements:
	echo 'Achievement.create(:name => "Colosseum", :description => "See the Colosseum", :color => "bronze", :id => 0)' | rails c
	echo 'Achievement.create(:name => "Big Ben", :description => "See the Big Ben", :color => "silver", :id => 1)' | rails c

create_has_earned:
	echo 'HasEarned.create(:achievement_id => 0, :profile_id => 0)' | rails c
	echo 'HasEarned.create(:achievement_id => 0, :profile_id => 1)' | rails c
	echo 'HasEarned.create(:achievement_id => 1, :profile_id => 1)' | rails c

clean_cities:
	echo 'City.delete_all' | rails c
	
clean_landmarks:
	echo 'Landmark.delete_all' | rails c
	
clean_achievements:
	echo 'Achievement.delete_all' | rails c
	
clean_dataset: clean_cities clean_landmarks clean_achievements

clean_admins:
	echo 'Admin.delete_all' | rails c

clean_users:
	echo 'User.delete_all' | rails c

create_admin: clean_admins
	echo 'Admin.create(email: "admin@example.com", password: "12345678", password_confirmation: "12345678")' | rails c

install:
	cd ../ && yarn install
	yarn install

run:
	foreman start
	
run_windows:
	rails s -b 10.0.2.15 & foreman start frontend

tests:
	rake cucumber
