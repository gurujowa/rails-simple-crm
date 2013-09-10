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
//= require jquery
//= require jquery_ujs
//= require jquery.ui.core
//= require bootstrap-switch.min
//= require jquery.cookie
//= require noty/jquery.noty
//= require noty/layouts/top
//= require noty/themes/default
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require jquery.balloon.min
//= require bootstrap-editable
//= require bootstrap-editable-rails
//= require jquery.timepicker.min
//= require fullcalendar
//= require gcal
//= require_tree .

$.fn.datepicker.dates['ja'] = {
		days: ["日曜", "月曜", "火曜", "水曜", "木曜", "金曜", "土曜", "日曜"],
		daysShort: ["日", "月", "火", "水", "木", "金", "土", "日"],
		daysMin: ["日", "月", "火", "水", "木", "金", "土", "日"],
		months: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
		monthsShort: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
		today: "今日",
		format: "yyyy/mm/dd"
	};
$(function(){
  $( ".datepicker" ).datepicker({format: 'yyyy/mm/dd', language: 'ja'});
  $('.dropdown-toggle').dropdown();
  $('.navbar li.dropdown').hover( function(){ $(this).addClass('open').find('ul').stop(true,true).hide().slideDown('fast'); }, function(){ $(this).removeClass('open').find('ul').stop(true,true).slideUp('fast'); } ); $('.navbar li.dropdown li').unbind('mouseover').unbind('mouseout');
});

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("tr").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("tbody.add_fields").append(content.replace(regexp, new_id));
}