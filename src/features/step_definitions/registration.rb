require 'httparty'

$user_email = "foobar@example.com"
$user_password = "12345678"

Given("I'm not a registered user") do

  query = {
  	:email => $user_email
  }

  url = 'http://localhost:3000/auth/exists'
  response = HTTParty.post(url, :query => query)

  !response.parsed_response['success']
end

When("I make a request to signup to the website") do

  query = {
  	"email" => $user_email,
  	"password" => $user_password,
  	"password_confirmation"	=> $user_password
  }

  url = 'http://localhost:3000/auth'
  $res = HTTParty.post(url, :query => query)

end

