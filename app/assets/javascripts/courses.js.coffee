jQuery ->
  $(".start_timepicker").timepicker
    minTime: "9:00"
    maxTime: "20:00"
    showDuration: false
    timeFormat: "H:i"
  $('.start_timepicker').on 'changeTime', ->
    $(".end_timepicker").timepicker

