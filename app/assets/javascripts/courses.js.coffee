jQuery ->
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

courseCalendarRender = (method) ->
  calendar_settings = $.fn.fullcalendar
  $.getJSON "/courses/calendar.json", (json)->
    calendar_settings.eventSources = json.eventSources
    $('#course_calendar').fullCalendar(calendar_settings)

  $.getJSON "/courses/observe.json", (json)->
    calendar_settings.eventSources = json.eventSources
    $('#observe_calendar').fullCalendar(calendar_settings)


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
      maxTime: '20:00',
      timeFormat: "H:i",
      showDuration: true
    $(st).parents("tr").find(".break_startpicker").timepicker("remove")
    $(st).parents("tr").find(".break_startpicker").timepicker
      minTime: min_time,
      maxTime: '20:00',
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
