require 'httparty'

$admin_email = 'admin@example.com'
$admin_password = '12345678'

Given("I'm a logged-in admin") do
 
  query = {
    :email => $admin_email,
    :password => $admin_password
  }
  
  url = 'http://localhost:3000/admin/auth/sign_in'
  response = HTTParty.post(url, :query => query)
  
  $admin_token = response.headers['access-token']
  
end

Given("There is at least one city") do
  query ={
    :city => {
      :name => "Rome",
      :country => "Italy"
    }
  }
  url = 'http://localhost:3000/citys'
  @res_city = HTTParty.post(url, :query => query) #on success it returns city attribute
end

When("I request to create a new landmark") do
  query ={
    :landmark => {
      :name => "Colosseum",
      :description => "The most important monument in Rome",
      :latitude => 41.890251,
      :longitude => 12.492373,
      :city_id => @res_city.parsed_response["id"]
    }
  }
  url = 'http://localhost:3000/landmarks'
  @res_landmark = HTTParty.post(url, :query => query)  
end

Then("I should be replied with 'landmark_created'") do
  @res_landmark.parsed_response["status"]
end
