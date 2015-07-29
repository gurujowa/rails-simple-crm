jQuery ->
  if ($("#order_course").length >= 1 )
    $("#order_sheet_send_to").selectize({create: true, sortField: "text"})
    $("#order_course").select2().on("change", (e) -> getCourseText(e.val))

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
[ 受講者数 ] #{json.students}
[ 研修日 ]
#{period_txt}
"""
    console.log txt
    $("#order_sheet_course_info").text(txt)
