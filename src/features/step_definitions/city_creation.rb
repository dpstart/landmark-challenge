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
    
    @admin_token = response.headers['access-token'] 
    @token_type = response.headers['token-type'] 
    @client = response.headers['client'] 
    @expiry = response.headers['expiry'] 
    @uid = response.headers['uid'] 
    
  end

When("I request to create new City") do
    
    query ={
        :city => {
          :name => "Milan",
          :country => "Italy"
        }
      }
      url = 'http://localhost:3000/citys'
      $res = HTTParty.post(url, :query => query, :headers => {"access-token" => @admin_token,
                                                                    "token-type" => @token_type,
                                                                    "client" => @client,
                                                                    "expiry" => @expiry,
                                                                    "uid" => @uid
                                                                    })
                                                                    
      city_id = $res.parsed_response['city']['id']
      
      query = {
        :name => "Milan"
      }
      url = 'http://localhost:3000/citys/' + city_id.to_s
      res = HTTParty.delete(url, :query => query, :headers => {"access-token" => @admin_token,
                                                                    "token-type" => @token_type,
                                                                    "client" => @client,
                                                                    "expiry" => @expiry,
                                                                    "uid" => @uid
                                                                    })
      
  end
  

  