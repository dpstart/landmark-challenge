require 'httparty'

$email = "foobar@example.com"
$password = "12345678"

Given("I'm not a registered user") do

  query = {
  	:email => $email
  }

  url = 'http://localhost:3000/auth/exists'
  response = HTTParty.post(url, :query => query)

  !response.parsed_response['success']
end

When("I make a request to signup to the website") do

  query = {
  	"email" => $email,
  	"password" => $password,
  	"password_confirmation"	=> $password
  }

  url = 'http://localhost:3000/auth'
  $response = HTTParty.post(url, :query => query)

end

Then("I should be replied with 'success'") do
  $response.parsed_response['success']
end

