require 'httparty'

$user_email = "foobar@example.com"
$user_password = "12345678"

Given("I'm a registered user") do

  query = {
  	:email => $user_email
  }

  url = 'http://localhost:3000/auth/exists'
  response = HTTParty.post(url, :query => query)

  response.parsed_response['success']
end

When("I make a request to sign-in using email and password") do

  query = {
  	"email" => $user_email,
  	"password" => $user_password,
  	"password_confirmation"	=> $user_password
  }

  url = 'http://localhost:3000/auth/sign_in'
  $login_response = HTTParty.post(url, :query => query)

end

Then("I should be replied with data containing a representation of the model") do
  $login_response.parsed_response['data'] != nil
end