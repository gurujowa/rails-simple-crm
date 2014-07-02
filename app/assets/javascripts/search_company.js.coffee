jQuery ->
  $(".search_company").width("400px")
  $(".search_company").select2
    placeholder: "検索してください"
    minimumInputLength: 1
    dropdownCssClass: "bigdrop"
    ajax:
      url: "/companies/name.json"
      dataType: "json"
      timeout: 1000
      data: (term, page) ->
        q: term 
      results: (data, page) -> 
        results: data.companies
    initSelection: (element, callback) ->
      id = $(element).val()
      if id isnt ""
        $.ajax("/companies/" + id + "/find.json",
          dataType: "json"
        ).done (data) ->
          callback data
  $(".search_lead").width("400px")
  $(".search_lead").select2
    placeholder: "検索してください"
    minimumInputLength: 1
    dropdownCssClass: "bigdrop"
    ajax:
      url: "/leads/name.json"
      dataType: "json"
      timeout: 1000
      data: (term, page) ->
        q: term 
      results: (data, page) -> 
        results: data.leads
    initSelection: (element, callback) ->
      id = $(element).val()
      if id isnt ""
        $.ajax("/leads/" + id + "/find.json",
          dataType: "json"
        ).done (data) ->
          callback data
