# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  change_client_search = ->
    if $("#estimate_client_type").val() == "company"
      $("#lead_search_area").hide()
      $("#company_search_area").show()
    else if $("#estimate_client_type").val() == "lead"
      $("#lead_search_area").show()
      $("#company_search_area").hide()

  change_client_search()
  $("#company_search").change ->
    if $("#estimate_client_type").val() == "company"
      $("#estimate_client_id").val($(this).val())
  $("#lead_search").change ->
    if $("#estimate_client_type").val() == "lead"
      $("#estimate_client_id").val($(this).val())
  $("#estimate_client_type").change ->
    change_client_search()

