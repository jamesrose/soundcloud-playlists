class TracksController < ApplicationController
  
  before_filter :current_user, :find_playlist

  respond_to :json
  
  def index
    respond_with @playlist.tracks.all
  end
  
  def create
    respond_with @playlist.tracks.create(params[:track])
  end
  
  def destroy
    respond_with @current_user.tracks.find(params[:id]).destroy
  end
  
  private
  
  def find_playlist
    @playlist = @current_user.playlists.find(params[:playlist_id]) if params[:playlist_id]
  end
  
end
