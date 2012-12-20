# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  
  $('#connectButton').click ->
    SC.initialize client_id: '97522a2c00d248614d25b3f6ceca1688', redirect_uri: 'http://localhost:3000/sessions/new'
    SC.connect -> location.href = '/'
        