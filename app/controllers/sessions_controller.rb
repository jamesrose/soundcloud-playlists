class SessionsController < ApplicationController
  
  # Get access token and find or create a new user.
  def new
    access_token = Soundcloud.new(
      client_id: SOUNDCLOUD_CONFIG[:client_id],
      client_secret: SOUNDCLOUD_CONFIG[:client_secret],
      redirect_uri:  SOUNDCLOUD_CONFIG[:client_callback]
    ).exchange_token(code: params[:code])
    
    client = Soundcloud.new(
      access_token: access_token.access_token
    )
    
    user = User.find_or_create_by(soundcloud_id: client.get('/me').id, access_token: access_token.access_token)
    session[:user_id] = user.id
  end
end
