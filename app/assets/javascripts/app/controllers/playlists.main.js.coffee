$ = jQuery.sub()

# Models
Playlist = App.Playlist

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
    'click .delete': 'delete'
    
  constructor: ->
    super
    @active @change
  
  render: ->
    @html @view('playlists/show')(playlist: @playlist)
  
  change: (params) =>
    @playlist = Playlist.find(params.id)
    @render()
  
  delete: ->
    @playlist.destroy() if confirm('Are you sure?')
    @navigate '/'
    
class App.PlaylistsMain extends Spine.Stack
  className: 'main stack'
    
  controllers:
    show: App.PlaylistsShow
    index: App.PlaylistsIndex
