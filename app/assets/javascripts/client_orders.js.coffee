jQuery ->
  $("#client_order_company_id").select2
    placeholder: "検索してください"
    minimumInputLength: 1
    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "http://api.rottentomatoes.com/api/public/v1.0/movies.json"
      dataType: "jsonp"
      data: (term, page) ->
        q: term # search term
        page_limit: 10

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data.movies


    formatResult: movieFormatResult # omitted for brevity, see the source of this page
    formatSelection: movieFormatSelection # omitted for brevity, see the source of this page
    dropdownCssClass: "bigdrop" # apply css that makes the dropdown taller
    escapeMarkup: (m) -> # we do not want to escape markup since we are displaying html in results
      m
