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

  if(0 < $(".period_resume_editable").size())
    $(".period_resume_editable").editable
      url: "/periods/update"
      type: "select"
      method: "POST"
      source: [
        {value: "notstart", text: "未着手"}
        {value: "unnecessary", text: "不要"}
        {value: "complete", text: "完了"}
      ]
