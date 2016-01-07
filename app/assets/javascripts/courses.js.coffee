jQuery ->
  $( ".timepicker ").timepicker()
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

  pickerReady()
  if ($(".full_calendar").length >= 1)
    courseCalendarRender()

getCalendarSources = ->
  eventSources = []
  if $("#course_check").prop("checked")
    eventSources.push({
      url:"/courses/calendar.json"
      color: "Maroon"
      textColor: "white"
      borderColor: "white"
      cache: true
    })
  if $("#course_task_check").prop("checked")
    eventSources.push({
      name: "course_task"
      url:"/course_tasks.json"
      color: "black"
      textColor: "white"
      borderColor: "white"
      cache: true
    })
  if $("#task_check").prop("checked")
    eventSources.push({
      name: "task"
      url:"/tasks.json"
      color: "brown"
      textColor: "white"
      borderColor: "white"
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

  $("#course_task_course_id").select2(width: "100%", placeholder: "コースを選択してください")


  $("#course_delete").click (e) ->
    e.preventDefault()
    form = $("#new_course_task")
    $.ajax({
        dataType: "json"
        url: "/course_tasks/"+ $("#id").val()
        type: "delete"
        data: {event_id: $("#event_id").val()}
        cache: false
        timeout: 10000
        success: (result)->
          console.log result
          $('#course_calendar').fullCalendar("removeEvents",result.event_id)
          noty({text: result.text , type: "success", timeout: 5000})
          $("#event_change_modal").modal('hide')
        error: (xhr, textStatus, error) ->
          console.log xhr
          noty({text: "エラーが発生しました" , type: "error", timeout: 5000})
    })

  $("#calendar_checkbox_group :checkbox").click ->
    sources = getCalendarSources()
    $('#course_calendar').fullCalendar("removeEvents")
    for s in sources then $('#course_calendar').fullCalendar("addEventSource", s)

pickerReady = ->
  $('.start_timepicker').each ->
    startPickerInit(this)
  $('.break_startpicker').each ->
    breakPickerInit(this)

lastPickerReady = ->
    startPickerInit($('.start_timepicker:last'))
    breakPickerInit($('.break_startpicker:last'))
    
startPickerInit = (e) ->
    $(e).timepicker
      minTime: "9:00",
      maxTime: "21:00",
      showDuration: false,
      timeFormat: "H:i"    
    setStartTimePicker(e)
    $(e).on 'selectTime',->
      setStartTimePicker(e)

breakPickerInit = (e) ->
    setBreakTimePicker(e)  
    $(e).on 'selectTime', ->
      setBreakTimePicker(e)
 
setStartTimePicker = (st) ->
    min_time = $(st).val()
    unless (min_time)
      min_time = "09:00"
    $(st).parents("tr").find(".end_timepicker").timepicker("remove")
    $(st).parents("tr").find(".end_timepicker").timepicker
      minTime: min_time,
      maxTime: '21:00',
      timeFormat: "H:i",
      showDuration: true
    $(st).parents("tr").find(".break_startpicker").timepicker("remove")
    $(st).parents("tr").find(".break_startpicker").timepicker
      minTime: min_time,
      maxTime: '21:00',
      step : 15,
      timeFormat: "H:i",
      showDuration: true
setBreakTimePicker = (st) ->
    min_time = $(st).val()
    unless (min_time)
      min_time = "09:00"
    $(st).parents("tr").find(".break_endpicker").timepicker("remove")
    $(st).parents("tr").find(".break_endpicker").timepicker
      minTime: min_time,
      maxTime: '10:00pm',
      step : 15,
      timeFormat: "H:i",
      showDuration: true


$(document).on 'nested:fieldAdded', ->
  $( ".timepicker ").timepicker()

