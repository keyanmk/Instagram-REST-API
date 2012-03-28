#Abstraction layer for making REST API calls/Instagram API
module InstaGram
  
  #Url to fetch the access token once you have the code
  def oauth_token_url
   "https://api.instagram.com/oauth/access_token"
  end
  
  
  #url to authorize the client and get the code
  #URL used in step 1 of oauth
  def oauth_authorization_url (client_id, redirect_uri, scope)
   "https://api.instagram.com/oauth/authorize/?client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}"
  end
  
  # Returns the token request data hash
  # which is posted to oauth get access token url
    def token_request_data
    
    data =      {
                      :client_id => client_id , 
                      :client_secret => client_secret, 
                      :grant_type => "authorization_code", 
                      :redirect_uri => redirect_uri ,
                      :code => params[:code],
  							
    }
    
  end
  
  
  # sends a request to the mentioned url with the data
  #method takes the values GET , POST
  def send_request(method, url, data)
    
    server = HTTPClient.new
    
    url = URI.escape(url)
    
    if(method == "post")
      respoll = server.post(url,data)
    elsif (method == "delete")
	  respoll = server.delete(url,data)
	else
      respoll = server.get(url,data)
    end
    
    res_stat = respoll.status

    if res_stat == 200
      json_data = JSON.parse(respoll.content)
    end
    
  end
 

  
end