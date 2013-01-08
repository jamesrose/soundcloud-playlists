$ = jQuery.sub()

# Models
Playlist = App.Playlist

class App.Playlists extends Spine.Controller  
  className: 'playlists'

  constructor: ->
    super

    # The content flashes if this isn't synchronous.
    Playlist.fetch(async: false)
    
    # Initialise the SoundCloud JS SDK for later.
    SC.initialize SC_CONFIG

    @main = new App.PlaylistsMain
    
    @routes
      '/playlists/:id': (params) ->
        @main.show.active(params)
      '/playlists': (params) ->
        @main.index.active(params)
      '/bookmarklet/:uri': (params) ->
        @main.bookmarklet.active(params)
      '/': (params) ->
        @main.index.active(params)

    @append @main
