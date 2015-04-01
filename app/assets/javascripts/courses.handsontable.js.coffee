handsonSettings = (response) ->
  setting = $.extend response, afterChange: (change, source) ->
    if (source == "loadData")
      return false
    q = $.map change, (n)->
      id = window["hot"].getDataAtCell(n[0],0)
      m = $.merge(n,[id])
      return [m]
    $.ajax 
      url: '/courses/progress_save'
      type: "get"
      data: {q: q, source: source}
  return setting

jQuery ->
  if document.getElementById("course_handsontable") != null
    window["hot"] = null
    container = document.getElementById('course_handsontable')
    load = $("#load")
    $.getJSON '/courses/progress.json', (res) ->
      res["columns"] = [
        {data: "id", readOnly: true, header: "ID"},
        {data: "course", header: "コース名", readOnly: true},
        {data: "company", header: "会社名", readOnly: true},
        {data: "responsible",header:"担当者",readOnly: true},
        {data: "day", type: "date", header: "研修日", dateFormat: "YYYY/MM/DD", correctFormat: true},
        {data: "teacher", type: "dropdown",source: res["teacherColumns"] , header: "講師"},
        {data: "observer", source: res["userColumns"], header:  "立ち会い", type: "dropdown"},
      ]

      res["colHeaders"] = $.map res["columns"], (n) -> n["header"]
      window["hot"] = new Handsontable(container,handsonSettings(res))


