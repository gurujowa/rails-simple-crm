jQuery ->
  $('#lead_histories_csv_button').click ->
    url = "#{location.protocol}//#{location.host}/lead_histories.csv#{location.search}"
    location.href = url

  if document.getElementById("lead_histories_total_pivot") != null
    table = $("#lead_histories_total_pivot")
    $.getJSON "/lead_histories/total.json",{user_id: table.data("user_id"), date: {month: table.data("month"), year: table.data("year")}}, (mps) ->
      table.pivotUI mps,
        rows: [
          "status"
        ]
        cols: ["week","day"]

  if document.getElementById("lead_histories_total_all_pivot") != null
    table = $("#lead_histories_total_all_pivot")
    $.getJSON "/lead_histories/total_all.json", (mps) ->
      table.pivotUI mps,
        rows: [ "user_name" ]
        cols: ["year","month"]
