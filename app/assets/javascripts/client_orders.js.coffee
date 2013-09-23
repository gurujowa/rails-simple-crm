jQuery ->
  $("#client_order_company_id").select2
    placeholder: "検索してください"
    minimumInputLength: 1
    dropdownCssClass: "bigdrop"
#    formatResult: (data) ->
#      return "aaa"
#    formatSelection: (data)->
#      return data.text
    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/companies/name.json"
      dataType: "json"
      timeout: 1000
      data: (term, page) ->
        q: term # search term

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data.companies

