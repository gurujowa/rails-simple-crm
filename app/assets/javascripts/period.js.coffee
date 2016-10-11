jQuery ->
  table = $('#period-datatables').DataTable
        "lengthChange": false
        "pageLength": 100
        "order": [[3,"asc"]]
  table.search("resume_notcomplete_flag").draw()
  $('#period-datatables').on 'draw.dt', ->
    period_editable_draw()
  $('#period-notstart-search-button').click table, ->
    table.search("resume_notcomplete_flag").draw()
  $('#period-unnecessary-search-button').click table, ->
    table.search("unnecessary").draw()
  $('#period-complete-search-button').click table, ->
    table.search("resume_complete_flag").draw()
  $('#period-notorder-search-button').click table, ->
    table.search("未発行").draw()
  period_editable_draw()
  $('.toggle-periods').on 'click', (e)->
    e.preventDefault()
    $(this).toggleClass("active")
    column = table.column($(this).attr('data-column'))
    column.visible( ! column.visible() )


@period_editable_draw = () ->
  if(0 < $(".period_editable").size())
    $(".period_editable").editable
      method: "POST"
      url: "/periods/update"

  if(0 < $(".order-avail-editable").size())
    $(".order-avail-editable").editable
      url: "/periods/update"
      method: "POST"
      type: "select"
      source: gon.order_avail_list


  if(0 < $(".period-check-editable").size())
    $(".period-check-editable").editable
      url: "/periods/update"
      type: "checklist"
      method: "POST"
      source: [
        {value: "teacher_announce", text: "講師連絡"}
        {value: "receive_resume", text: "レジュメ到着"}
        {value: "check_resume", text: "正誤チェック"}
        {value: "unnecessary", text: "発送済み"}
        {value: "sent", text: "不要"}
      ]
