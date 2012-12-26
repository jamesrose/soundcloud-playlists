class App.Playlist extends Spine.Model
  @configure 'Playlist', 'title', 'description'
  @extend Spine.Model.Ajax

  @hasMany 'tracks', 'App.Track'

  trackUrl = 'http://api.soundcloud.com/tracks/'

  play: (player) => @playNext @tracks().all(), player
  
  # Play tracks until we run out, at which point
  # remove the player.
  playNext: (tracks, player) =>
    return $(player).html('') unless tracks.length
    SC.oEmbed trackUrl + tracks.shift().soundcloud.id, auto_play: true, (track) =>
      $(player).html track.html
      SC.Widget($('iframe').get(0)).bind SC.Widget.Events.FINISH, => 
        @playNext(tracks, player)
        