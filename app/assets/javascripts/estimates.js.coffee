# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#estimate_company_id").select2
    placeholder: "検索してください"
    minimumInputLength: 1
    dropdownCssClass: "bigdrop"
    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/companies/name.json"
      dataType: "json"
      timeout: 1000
      data: (term, page) ->
        q: term 

      results: (data, page) -> # parse the results into the format expected by Select2.
        results: data.companies
    initSelection: (element, callback) ->
      id = $(element).val()
      if id isnt ""
        $.ajax("/companies/" + id + "/find.json",
          dataType: "json"
        ).done (data) ->
          console.log data
          callback data


  $('#estimate_calc_button').on 'click', ->
     return false
     
