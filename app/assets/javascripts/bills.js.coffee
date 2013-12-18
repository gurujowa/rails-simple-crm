# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $(".search_billing_plan_line").width("400px")
  $(".search_billing_plan_line").select2
    placeholder: "検索してください"
    minimumInputLength: 1
    dropdownCssClass: "bigdrop"
    ajax:
      url: "/bills/search.json"
      dataType: "json"
      timeout: 1000
      data: (term, page) ->
        q: term 
      results: (data, page) -> 
        results: data.companies
    initSelection: (element, callback) ->
      id = $(element).val()
      if id isnt ""
        $.ajax("/bills/" + id + "/find.json",
          dataType: "json"
        ).done (data) ->
          callback data
