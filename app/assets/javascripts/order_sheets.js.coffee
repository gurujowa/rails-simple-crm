jQuery ->
  if ($("#order_course").length >= 1 )
    $("#order_sheet_send_to").selectize({create: true, sortField: "text"})
    $("#order_course").select2().on("select2:select", (e) ->
      console.log e.params.data.id
      getCourseText(e.params.data.id)
    )

getCourseText = (val) ->
  url = "/courses/" + val + ".json"
  teacher_name = $("#order_sheet_send_to").text()

  $.getJSON url, (json) ->
    period_txt = ""
    $.each json.periods, () ->
      if teacher_name == this.teacher
        period_txt = period_txt + this.day + "\n"
    txt = """
[ 登壇講師 ] #{teacher_name}
[ コース名 ] #{json.name}
[ 会場住所 ] #{json.address}
[ 最寄り駅 ] #{json.station}
[ 先方研修担当者 ] #{json.responsible}
[ 先方緊急連絡先 ] #{json.tel}
[ 参加人数 ] #{json.students}
[ 日程 ]
#{period_txt}
"""
    console.log txt
    $("#order_sheet_course_info").text(txt)
