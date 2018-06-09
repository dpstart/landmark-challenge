COLOSSEUM_DESCRIPTION = "The Colosseum or Coliseum, also known as the Flavian Amphitheatre, is an oval amphitheatre in the centre of the city of Rome, Italy."
BATHS_OF_CARACALLA_DESCRIPTION = "The Baths of Caracalla in Rome, Italy, were the citys second largest Roman public baths, or thermae, likely built between AD 212 and 216/217, during the reigns of emperors Septimius Severus and Caracalla. They were in operation until the 530s and then fell into disuse and ruin."
MILAN_CATHEDRAL_DESCRIPTION = "Milan Cathedral is the cathedral church of Milan, Lombardy, Italy. Dedicated to St Mary of the Nativity (Santa Maria Nascente), it is the seat of the Archbishop of Milan, currently Archbishop Mario Delpini. The cathedral took nearly six centuries to complete. It is the largest church in Italy (the larger St. Peter\s Basilica is in the State of Vatican City) and the third largest in the world."
BIG_BEN_DESCRIPTION = "Big Ben is the nickname for the Great Bell of the clock at the north end of the Palace of Westminster in London and is usually extended to refer to both the clock and the clock tower. The official name of the tower in which Big Ben is located was originally the Clock Tower, but it was renamed Elizabeth Tower in 2012 to mark the Diamond Jubilee of Elizabeth II."
EIFFEL_TOWER_DESCRIPTION = "The Eiffel Tower is a wrought iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower."
VAN_GOGH_MUSEUM_DESCRIPTION = "The Van Gogh Museum is an art museum dedicated to the works of Vincent van Gogh and his contemporaries in Amsterdam in the Netherlands. It is located at the Museum Square in the borough Amsterdam South, close to the Stedelijk Museum, the Rijksmuseum, and the Concertgebouw."
SAGRADA_FAMILIA_DESCRIPTION = "The Basílica i Temple Expiatori de la Sagrada Família is a large unfinished Roman Catholic church in Barcelona, designed by Catalan architect Antoni Gaudí (1852–1926). Gaudís work on the building is part of a UNESCO World Heritage Site, and in November 2010 Pope Benedict XVI consecrated and proclaimed it a minor basilica, as distinct from a cathedral, which must be the seat of a bishop."

create_cities:
	echo 'City.create(:name => "Rome", :country => "Italy", :latitude => 41.8919300, :longitude => 12.5113300,:id => 0)' | rails c
	echo 'City.create(:name => "Milan", :country => "Italy", :latitude => 45.4642700, :longitude => 9.1895100, :id => 1)' | rails c
	echo 'City.create(:name => "London", :country => "United Kingdom", :latitude => 51.509865, :longitude => -0.118092, :id => 2)' | rails c
	echo 'City.create(:name => "Paris", :country => "France", :latitude => 48.864716, :longitude => 2.349014, :id => 3)' | rails c
	echo 'City.create(:name => "Amsterdam", :country => "Netherlands", :latitude => 52.370216, :longitude => 4.895168, :id => 4)' | rails c
	echo 'City.create(:name => "Barcellona", :country => "Spain", :latitude => 41.390205, :longitude => 2.154007, :id => 5)' | rails c
	
create_landmarks: create_cities
	echo 'Landmark.create(:description => ${COLOSSEUM_DESCRIPTION}, :name => "Colosseum", :latitude => 41.890251, :longitude => 12.492373, :city_id => 0, :img_URL => "https://dotravel.com/uploads/ticket/1234/2017-12-05/Colosseum-Tickets-1.jpg", :id => 0)' | rails c
	echo 'Landmark.create(:description => ${BATHS_OF_CARACALLA_DESCRIPTION}, :name => "Baths of Caracalla", :latitude => 41.879444, :longitude => 12.492056, :city_id => 0, :id => 1)' | rails c
	echo 'Landmark.create(:description => ${MILAN_CATHEDRAL_DESCRIPTION}, :name => "Milan Cathedral", :latitude => 45.458536, :longitude => 9.187387, :city_id => 1, :id => 2)' | rails c
	echo 'Landmark.create(:description => ${BIG_BEN_DESCRIPTION}, :name => "Big Ben", :latitude => 51.500364, :longitude => -0.121432, :city_id => 2, :id => 3)' | rails c
	echo 'Landmark.create(:description => ${EIFFEL_TOWER_DESCRIPTION}, :name => "Eiffel Tower", :latitude => 48.8583, :longitude => 2.2945, :city_id => 3, :id => 4)' | rails c
	echo 'Landmark.create(:description => ${VAN_GOGH_MUSEUM_DESCRIPTION}, :name => "Van Gogh Museum", :latitude => 52.358415, :longitude => 4.881075, :city_id => 4, :id => 5)' | rails c
	echo 'Landmark.create(:description => ${SAGRADA_FAMILIA_DESCRIPTION}, :name => "Sagrada Familia (\"Expiatory Temple of the Holy Family\")", :latitude => 41.402165, :longitude => 2.171332, :city_id => 5, :id => 6)' | rails c

create_users:
	echo 'User.create(:email => "luca@gmail.com", :password => "passpass", :password_confirmation => "passpass", :id => 0)' | rails c
	echo 'User.create(:email => "daniele@gmail.com", :password => "passpass", :password_confirmation => "passpass", :id => 1)' | rails c
	
create_profiles:
	echo 'Profile.create(:first_name => "Luca", :last_name => "Ferrera", :user_id => 0,:id => 0)' | rails c
	echo 'Profile.create(:first_name => "Daniele", :last_name => "Cappuccio", :user_id => 1, :id => 1)' | rails c

create_achievements:
	echo 'Achievement.create(:name => "Colosseum", :description => "See the Colosseum", :color => "bronze", :id => 0)' | rails c
	echo 'Achievement.create(:name => "Big Ben", :description => "See the Big Ben", :color => "bronze", :id => 1)' | rails c
	echo 'Achievement.create(:name => "Visit 5 landmarks", :description => "Visit 5 landmarks", :color => "silver", :id => 2)' | rails c
	echo 'Achievement.create(:name => "Welcome", :description => "Visit your first landmark", :color => "silver", :id => 3)' | rails c
	
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
