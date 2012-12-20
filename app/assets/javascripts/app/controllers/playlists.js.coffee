$ = jQuery.sub()

# Models
Playlist = App.Playlist

class App.Playlists extends Spine.Controller  
  className: 'playlists'
    
  constructor: ->
    super
    
    # The content flashing if this isn't synchronous.
    Playlist.fetch(async: false)
    
    @main = new App.PlaylistsMain
    
    @routes
      '/playlists/:id': (params) ->
        @main.show.active(params)
      '/playlists': (params) ->
        @main.index.active(params)
      '/': (params) ->
        @main.index.active(params)

    @append @main