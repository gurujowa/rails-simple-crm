# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org
jQuery ->
  $("#lead_tag_list_form").select2
    width: "400px"
    tags: gon.tag_list
    console.log gon.tag_list
  $("#lead_tag_list_search").select2
    width: "400px"
