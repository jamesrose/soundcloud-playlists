$ = jQuery.sub()

# Models
Playlist = App.Playlist
Track = App.Track

class App.PlaylistsIndex extends Spine.Controller
  className: 'index'

  events:
    'submit form': 'submit'
    'click .show': 'show'

  elements:
    'form': 'form'

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

  show: (e) ->
    @navigate('/playlists', $(e.target).data('id'))

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
  
  play: (e) =>
    tracks = @playlist.tracks().all().map (track) -> track.soundcloud_id
    @playSong tracks
  
  playSong: (tracks) ->
    SC.oEmbed "http://api.soundcloud.com/tracks/#{tracks.pop()}", auto_play: true, (track) ->
      $(@player).html track.html
      console.log track

  home: -> @navigate '/'

class App.PlaylistsMain extends Spine.Stack
  className: 'main stack'

  constructor: ->
    super
    Playlist.fetch()  

  controllers:
    show: App.PlaylistsShow
    index: App.PlaylistsIndex
