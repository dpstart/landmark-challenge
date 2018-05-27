require 'httparty'

$admin_email = 'admin@example.com'
$admin_password = '12345678'

Given("I'm admin logged-in") do
 
    query = {
      :email => $admin_email,
      :password => $admin_password
    }
    
    url = 'http://localhost:3000/admin/auth/sign_in'
    response = HTTParty.post(url, :query => query)
    
    $admin_token = response.headers['access-token']
    
  end

When("I request to create new City") do
    
    query ={
        :city => {
          :name => "Rome",
          :country => "Italy"
        }
      }
      url = 'http://localhost:3000/citys'
      @res_city = HTTParty.post(url, :query => query) #on success it returns city attribute
  end
  
Then("I shoul be replied with {string}") do |string|
    @res_city.parsed_response["status"]
end
  
  