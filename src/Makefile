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
