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

When("I request to create a new landmark") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should be replied with a message indicating the operation was successful") do
  pending # Write code here that turns the phrase above into concrete actions
end
