# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
 $("#analysis_change").on "change", ->
  location.href = "/lead_histories/" + $(this).val() + "/analysis"
