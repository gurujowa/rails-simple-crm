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
  calcTime()
  periodCalendarRender()
  courseCalendarRender()

  $(document).on 'click' , '.period_img',  ->
    hidden_value = $(this).parent().find('.period_hidden').val()
    if (hidden_value == "t")
      $(this).attr("src", "/img/cross.png")
      $(this).parent().find('.period_hidden').val("f")
    else if (hidden_value == "f" or hidden_value == "false")
      $(this).attr("src", "/img/check.png")
      $(this).parent().find('.period_hidden').val("t")
    else
      alert("チェックの状況が正しくありません。管理者を呼んでください")
  $('#calc_button').on 'click', ->
    calcTime()
    calendarRender("render")
    return false

  $('#add_field_button').on 'click', ->
     lastPickerReady()
     $(".start_timepicker").eq(-1).val($(".start_timepicker").eq(-2).val())
     $(".end_timepicker").eq(-1).val($(".end_timepicker").eq(-2).val())
     $(".break_startpicker").eq(-1).val($(".break_startpicker").eq(-2).val())
     $(".break_endpicker").eq(-1).val($(".break_endpicker").eq(-2).val())
     $(".select_teacher_id").eq(-1).val($(".select_teacher_id").eq(-2).val())
     $( ".course_datepicker" ).datepicker({format: 'yyyy/mm/dd', language: 'ja'})

periodCalendarRender = (method) ->
  calendar_settings = $.fn.fullcalendar
  calendar_settings.eventSources = new Array
  calendar_settings.eventSources[0] ={
    color: 'black'
    textColor: 'white'
  }

  i = 1
  events = new Array
  $('#periods_table tbody tr').each ->
    events.push
      title: "研修" + i
      start: $(this).find(".datepicker").val() + " " + $(this).find(".start_timepicker").val()
      end: $(this).find(".datepicker").val() + " " + $(this).find(".end_timepicker").val()
      allDay: false
    i++  
  calendar_settings.eventSources[0].events = events
  if (method == "render")
    $('#period_calendar').fullCalendar('destroy')
  $('#period_calendar').fullCalendar(calendar_settings)


courseCalendarRender = (method) ->
  calendar_settings = $.fn.fullcalendar
  $.getJSON "/courses/calendar.json", (json)->
    calendar_settings.eventSources = json.eventSources
    $('#course_calendar').fullCalendar(calendar_settings)

  $.getJSON "/courses/observe.json", (json)->
    calendar_settings.eventSources = json.eventSources
    $('#observe_calendar').fullCalendar(calendar_settings)


calcTime = ->
  total_time = 0
  $(".total_period_time").each ->
     st = $(this).parents("tr").find(".start_timepicker").timepicker('getTime')
     ed = $(this).parents("tr").find(".end_timepicker").timepicker('getTime')
     bs = $(this).parents("tr").find(".break_startpicker").timepicker('getTime')
     be = $(this).parents("tr").find(".break_endpicker").timepicker('getTime')
     total_minute = (ed - st)/(1000*60) - (be - bs)/ (1000*60)
     total_string = Math.floor(total_minute / 60) + "時間" + total_minute % 60 + "分"
     total_time += total_minute
     $(this).text(total_string)
  $("#total_course_time").text(Math.floor(total_time / 60) + "時間" + total_time % 60 + "分")

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
