require 'httparty'

Given("I'm not a registered user") do
  true
end

When("I make a request to signup to the website") do

  query = {
  	"email" 				=> "foo@example.com",
  	"password" 				=> "12345678",
  	"password_confirmation" => "12345678"
  }

  url = 'http://localhost:3000/auth'
  $response = HTTParty.post(url, :query => query)

end

Then("I should be replied with 'success'") do
  $response.parsed_response['success']
end

