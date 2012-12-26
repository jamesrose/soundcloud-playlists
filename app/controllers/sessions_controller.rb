class SessionsController < ApplicationController
  
  # Get access token and find or create a new user.
  def new
    access_token = Soundcloud.new(
      client_id: ENV['soundcloud_client_id'],
      client_secret: ENV['soundcloud_client_secret'],
      redirect_uri:  ENV['soundcloud_callback_url']
    ).exchange_token(code: params[:code])
    
    client = Soundcloud.new(
      access_token: access_token.access_token
    )
    
    user = User.find_or_create(client.get('/me').id, access_token.access_token)
    session[:user_id] = user.id
  end
end
