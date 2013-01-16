$ = jQuery.sub()

# Models
Playlist = App.Playlist
Track = App.Track

# Route: /
class App.PlaylistsIndex extends Spine.Controller
  className: 'index'

  events:
    'submit form': 'submit'
    'click .show': 'show'
    'click .play': 'play'

  elements:
    'form': 'form'
    '#player': 'player'

  constructor: ->
    super
    @active @change

    Playlist.bind 'change refresh', @change

  render: ->
    @html @view('playlists/index')(playlists: @playlists)

  change: (params) =>
    @playlists = Playlist.all()
    @render()

  submit: (e) ->
    e.preventDefault()
    @playlist = Playlist.fromForm(@form).save()
    @navigate('/playlists', @playlist.id)

  show: (e) -> @navigate('/playlists', $(e.target).data('id'))

  play: (e) => Playlist.find($(e.target).data('id')).play(@player)

# Route: /playlists/:id
class App.PlaylistsShow extends Spine.Controller
  className: 'show'

  events:
    'click #playlist-controls .delete': 'delete'
    'click .home': 'home'
    'submit form': 'addTrack'
    'click .track .delete': 'deleteTrack'
    'click .play': 'play'

  elements:
    'form': 'form'
    '#uri': 'uri'
    '#player': 'player'

  constructor: ->
    super
    @active @change
    
    # Re-render view when a track is added or removed.
    Track.bind 'change refresh', => @render()

  render: ->
    @html @view('playlists/show')(playlist: @playlist)

  change: (params) =>
    @playlist = Playlist.find(params.id)
    @render()

  delete: ->
    @playlist.destroy() if confirm('Are you sure?')
    @navigate '/'

  addTrack: (e) =>
    e.preventDefault()
    @playlist.tracks().create uri: @uri.val()
    @render()

  deleteTrack: (e) =>
    e.preventDefault()
    Track.find($(e.target).data('id')).destroy()
  
  play: => @playlist.play(@player)
  
  home: -> @navigate '/'

# Route: /bookmarklet
class App.PlaylistsBookmarklet extends Spine.Controller
  className: 'bookmarklet'
  
  events:
    'click .playlist .add': 'addTrack'
  
  constructor: ->
    super
    @active @change
    
    Track.bind 'ajaxSuccess', => window.close()
  
  render: ->
    @html @view('playlists/bookmarklet')(playlists: @playlists, track: @track)
  
  change: (params) =>
    @playlists = Playlist.all()
    @track = new Track uri: decodeURIComponent(params.uri)
    @render()
  
  addTrack: (e) =>
    e.preventDefault()
    @playlist = Playlist.find($(e.target).data('id'))
    @playlist.tracks().create uri: @track.uri
    @html "Your track has been added."

class App.PlaylistsMain extends Spine.Stack
  className: 'main stack'

  constructor: ->
    super
    Playlist.fetch()  

  controllers:
    show: App.PlaylistsShow
    index: App.PlaylistsIndex
    bookmarklet: App.PlaylistsBookmarklet
