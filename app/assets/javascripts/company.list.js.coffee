# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#companies_address_label').click ->
    sData = $('input.companies_index_checkbox').serialize()
    if sData == "" 
      alert("チェックがありません")
      return false
    w = window.open()
    w.location.href = "/companies/address.csv?" + sData
    return false 
  $('#companies_all_checkbox').on 'change', ->
    $('.companies_index_checkbox').prop('checked', this.checked)

  $("#company_tag_list_search").select2
    width: "400px"
