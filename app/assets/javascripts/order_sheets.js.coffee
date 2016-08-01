jQuery ->
  if ($("#order_course").length >= 1 )
    $("#order_sheet_send_to").selectize({create: true, sortField: "text"})
    $("#order_course").select2().on "select2:select", (e) ->
      getCourseText(e.params.data.id)
  $("#order_sheet_period_ids").select2
    placeholder: "発注済みにするコマを選択してください"

getCourseText = (val) ->
  url = "/courses/" + val + ".json"
  teacher_name = $("#order_sheet_send_to").text()

  $.getJSON url, (json) ->
    period_txt = ""
    address_txt = ""

    $.each json.periods, () ->
      if teacher_name == this.teacher
        period_txt = period_txt + this.day + "\n"

    $.each json.course_addresses, (i) ->
      ad_text = """
------------会場#{i+1}-------------------
[ 会場名 ] #{this.name}
[ 会場住所 ] #{this.address}
[ 最寄り駅 ] #{this.station}
[ 研修運営担当者 ] #{this.responsible}
[ 会場電話番号 ] #{this.tel}
[ プロジェクター ] #{this.projector_text}
[ ホワイトボード ] #{this.board_text}
"""
      address_txt = address_txt +  ad_text + "\n"

    txt = """
[ 登壇講師 ] #{teacher_name}
[ コース名 ] #{json.name}
[ 参加人数 ] #{json.students}
[ 日程 ]
#{period_txt}#{address_txt}
"""
    $("#order_sheet_course_info").text(txt.replace(/null/g,''))
