// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require moment.min
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.datetimepicker
//= require bootstrap
//= require bootstrap-switch.min
//= require jquery.cookie
//= require fullcalendar/fullcalendar.min
//= require fullcalendar/ja
//= require fullcalendar/gcal
//= require noty/jquery.noty
//= require noty/layouts/top
//= require noty/themes/default
//= require jquery.balloon.min
//= require jquery.timepicker.min
//= require selectize.min
//= require handsontable.full.min
//= require pivot
//= require pikaday
//= require_tree .
//= require jquery_nested_form
//


$(document).on('nested:fieldAdded', function(event){
  init_date_picker();
  $( ".datetimepicker" ).datetimepicker({lang:'ja',scrollInput: false,
 i18n:{
  ja:{
   months:[ '1月','2月','3月','4月', '5月','6月','7月','8月', '9月','10月','11月','12月', ],
   dayOfWeek:[ "日", "月", "火", "水", "木", "金", "土", ]
  }
 }});
  $( ".timepicker ").timepicker();
})

$(function(){
  $('.default_datatables').dataTable( {
        "lengthChange":     false,
        "pageLength":     100,
        "bStateSave": true
    } );  
  init_date_picker()
  $( ".datetimepicker" ).datetimepicker({lang:'ja',scrollInput: false,
 i18n:{
  ja:{
   months:[ '1月','2月','3月','4月', '5月','6月','7月','8月', '9月','10月','11月','12月', ],
   dayOfWeek:[ "日", "月", "火", "水", "木", "金", "土", ]
  }
 }});
  $('.dropdown-toggle').dropdown();
  $("[data-toggle=tooltip]").tooltip()
  $( ".timepicker ").timepicker();
});

function init_date_picker() {
  $( ".datepicker" ).datetimepicker({lang:'ja',timepicker: false, format: "Y/m/d",scrollInput: false,
 i18n:{
  ja:{
   months:[ '1月','2月','3月','4月', '5月','6月','7月','8月', '9月','10月','11月','12月', ],
   dayOfWeek:[ "日", "月", "火", "水", "木", "金", "土", ]
  }
 }});

}

function submit_format(form, format) {
  $(form).submit(function(){
  $('<input />').attr('type', 'hidden')
   .attr('name', 'format')
   .attr('value', format)
   .appendTo(form);
  });
}
