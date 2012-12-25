class App.Playlist extends Spine.Model
  @configure 'Playlist', 'title', 'description'
  @extend Spine.Model.Ajax

  @hasMany 'tracks', 'App.Track'
  
  trackUrl = 'http://api.soundcloud.com/tracks/'

  play: (player) => @playNext @tracks().all(), player

  playNext: (tracks, player) =>
    return $(player).html('') unless tracks.length
    SC.oEmbed trackUrl + tracks.shift().soundcloud_id, auto_play: true, (track) =>
      $(player).html track.html
      $('.play').html '&#9658;' 
      SC.Widget($('iframe').get(0)).bind SC.Widget.Events.FINISH, => 
        @playNext(tracks, player)
        