//= require moment.min
//= require jquery2
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-switch.min
//= require jquery.cookie
//= require fullcalendar/fullcalendar.min
//= require fullcalendar/ja
//= require fullcalendar/gcal
//= require bootstrap-datetimepicker
//= require noty/jquery.noty
//= require noty/layouts/top
//= require noty/themes/default
//= require jquery.balloon.min
//= require jquery.timepicker.min
//= require selectize.min
//= require pivot
//= require pikaday
//= require handsontable.full.min
//= require_tree .
//= require jquery_nested_form
//

$(function(){
  $('.default_datatables').dataTable( {
        "lengthChange":     false,
        "pageLength":     100,
        "bStateSave": true
    } );
  $( ".datetimepicker" ).datetimepicker({format: "YYYY-MM-DD HH:mm:ss", sideBySide: true});
  $( ".datepicker" ).datetimepicker({enabledHours: false, format: "YYYY-MM-DD"});
  $('.dropdown-toggle').dropdown();
  $("[data-toggle=tooltip]").tooltip();
  $(".simple-form-select2").select2();
});

$(document).on("nested:fieldAdded", function (event) {
  $( ".datetimepicker" ).datetimepicker({format: "YYYY-MM-DD HH:mm:ss", sideBySide: true});
  $( ".datepicker" ).datetimepicker({enabledHours: false, format: "YYYY-MM-DD"});
});


function submit_format(form, format) {
  $(form).submit(function(){
  $('<input />').attr('type', 'hidden')
   .attr('name', 'format')
   .attr('value', format)
   .appendTo(form);
  });
}
