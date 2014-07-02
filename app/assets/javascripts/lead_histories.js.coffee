jQuery ->
  table = $("#lead_histories_total_pivot")
  $.getJSON "/lead_histories/total.json",{user_id: table.data("user_id"), date: {month: table.data("month"), year: table.data("year")}}, (mps) ->
    table.pivotUI mps,
      rows: [
        "status"
      ]
      cols: ["day"]
