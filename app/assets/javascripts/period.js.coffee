jQuery ->
  table = $('#period-datatables').DataTable
        "lengthChange": false
        "pageLength": 100
        "order": [[2,"asc"]]
  $('#period-datatables').on 'draw.dt', ->
    period_editable_draw()
  $('#period-notstart-search-button').click table, ->
    table.search("未着手").draw()
  $('#period-unnecessary-search-button').click table, ->
    table.search("不要").draw()
  $('#period-complete-search-button').click table, ->
    table.search("完了").draw()
  period_editable_draw()


@period_editable_draw = () ->
  if(0 < $(".period_editable").size())
    $(".period_editable").editable
      method: "POST"
      url: "/periods/update"


  if(0 < $(".period-check-editable").size())
    $(".period-check-editable").editable
      url: "/periods/update"
      type: "checklist"
      method: "POST"
      source: [
        {value: 0, text: "講師連絡"}
        {value: 1, text: "レジュメ到着"}
        {value: 2, text: "正誤チェック"}
        {value: 3, text: "不要"}
      ]
