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
  
  @admin_token = response.headers['access-token'] 
  @token_type = response.headers['token-type'] 
  @client = response.headers['client'] 
  @expiry = response.headers['expiry'] 
  @uid = response.headers['uid'] 
  
end

Given("There is at least one city") do
  query = {
    :city => {
      :name => "Madrid",
      :country => "Spain"
    }
  }
  url = 'http://localhost:3000/citys'
  @res_city = HTTParty.post(url, :query => query, :headers => {"access-token" => @admin_token,
                                                              "token-type" => @token_type,
                                                              "client" => @client,
                                                              "expiry" => @expiry,
                                                              "uid" => @uid
                                                              }) #on success it returns city attribute
  $city_id = @res_city.parsed_response["city"]["id"]
end

When("I request to create a new landmark") do
  query ={
    :landmark => {
      :name => "El Prado",
      :description => "The most important museum of Madrid",
      :latitude => 40.4083317, 
      :longitude => -3.688830578,
      :city_id => $city_id
    }
  }
  url = 'http://localhost:3000/landmarks'
  landmark_res = HTTParty.post(url, :query => query, :headers => {"access-token" => @admin_token,
                                                                  "token-type" => @token_type,
                                                                  "client" => @client,
                                                                  "expiry" => @expiry,
                                                                  "uid" => @uid
                                                                  })  
  city_id = landmark_res.parsed_response['city_id']
  landmark_id = landmark_res.parsed_response['landmark_id']

  query = {
    :name => "Madrid"
  }
  url = 'http://localhost:3000/citys/' + city_id.to_s
  res = HTTParty.delete(url, :query => query, :headers => { "access-token" => @admin_token,
                                                            "token-type" => @token_type,
                                                            "client" => @client,
                                                            "expiry" => @expiry,
                                                            "uid" => @uid
                                                          })

  query = {
    :name => "El Prado"
  }
  url = 'http://localhost:3000/landmarks/' + landmark_id.to_s
  res = HTTParty.delete(url, :query => query, :headers => { "access-token" => @admin_token,
                                                            "token-type" => @token_type,
                                                            "client" => @client,
                                                            "expiry" => @expiry,
                                                            "uid" => @uid
                                                          })
end

Then("I should be replied with {string}") do |string|
  response = $res.parsed_response["status"] 
  response == string
end
