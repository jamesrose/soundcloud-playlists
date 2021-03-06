# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  # Initiate client-side auth flow with SC. 
  $('#connectButton').click ->
    SC.initialize client_id: SC_CONFIG.client_id, redirect_uri: "#{SC_CONFIG.client_url}/sessions/new"
    SC.connect -> location.href = '/'
