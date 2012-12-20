class PlaylistsController < ApplicationController
  respond_to :json
  
  def index
    respond_with @current_user.playlists
  end
  
  def create
    respond_with @current_user.playlists.create(params[:playlist])
  end
  
  def destroy
    respond_with @current_user.playlists.find(params[:id]).destroy
  end
end
