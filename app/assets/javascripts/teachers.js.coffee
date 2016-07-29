jQuery ->
  if ($("#teacher-booking-calendar").length >= 1)
    $('#teacher-booking-calendar').fullCalendar
      firstDay: 0
      weekNumber: true
      businessHours:
        start: "09:00"
        end: "20:00"
      timeFormat:"H:mm"
      header:
        left: 'prev,next today'
        center: 'title'
        right: "month,agendaWeek,agendaDay"
    loading: (bool)->
      if bool
        $('#loading').show()
      else
        $('#loading').hide()
  $(".teacher-booking-trigger").click (e) ->
    $.getJSON $(this).data("url"), (data) ->
      $('#teacher-booking-calendar').fullCalendar("removeEvents")
      $('#teacher-booking-calendar').fullCalendar("addEventSource", data)
