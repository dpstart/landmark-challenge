clean_users:
	echo 'User.delete_all' | rails c

create_admin:
	echo 'Admin.delete_all' | rails c
	echo 'Admin.create(email: "admin@example.com", password: "12345678", password_confirmation: "12345678")' | rails c

install:
	cd ../ && yarn install
	yarn install

run:
	foreman start

test:
	rake cucumber
