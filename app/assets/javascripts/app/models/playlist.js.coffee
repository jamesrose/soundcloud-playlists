class App.Playlist extends Spine.Model
  @configure 'Playlist', 'title', 'description'
  @extend Spine.Model.Ajax

  @hasMany 'tracks', 'App.Track'

  play: (player) => @playNext @tracks().all(), player
  
  # Play tracks until we run out, at which point
  # remove the player.
  playNext: (tracks, player) =>
    return $(player).html('') unless tracks.length
    SC.oEmbed tracks.shift().soundcloud.uri, auto_play: true, (track) =>
      $(player).html track.html
      SC.Widget($('iframe').get(0)).bind SC.Widget.Events.FINISH, => 
        @playNext(tracks, player)
        