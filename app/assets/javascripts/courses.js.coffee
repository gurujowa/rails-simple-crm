jQuery ->
  $(".select_teacher_id").selectize({sortField: "text"})
  $( ".timepicker ").timepicker(
      minTime: "09:00",
      maxTime: "21:00",
      show2400: true,
      showDuration: false,
      timeFormat: "H:i"
  )
  $("#course_company_id").select2
    placeholder: "検索してください"
    minimumInputLength: 1
    dropdownCssClass: "bigdrop"
    ajax: 
      url: "/companies/name.json"
      dataType: "json"
      timeout: 1000
      data: (term, page) ->
        q: term 

      results: (data, page) -> 
        results: data.companies

  if ($(".full_calendar").length >= 1)
    courseCalendarRender()

getCalendarSources = ->
  eventSources = []
  if $("#course_check").prop("checked")
    eventSources.push({
      url:"/courses/calendar.json"
      color: "Maroon"
      textColor: "white"
      cache: true
    })
  if $("#holiday_check").prop("checked")
    eventSources.push({
      googleCalendarId: "ja.japanese#holiday@group.v.calendar.google.com"
      classname: "holiday-google"
      color: "blue"
    })
  return eventSources
courseCalendarRender = (method) ->
  eventSources = getCalendarSources()

  $('#course_calendar').fullCalendar
    googleCalendarApiKey: gon.google_api_key
    eventSources: eventSources
    firstDay: 0
    weekNumber: true
    eventClick: (event) ->
      if (event.url)
        window.open(event.url)
        return false
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


$(document).on 'nested:fieldAdded', ->
  $( ".timepicker ").timepicker(
      minTime: "09:00",
      maxTime: "21:00",
      show2400: true,
      showDuration: false,
      timeFormat: "H:i"
  )

