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
//= require jquery.ui.all
//= require jquery.datetimepicker
//= require bootstrap
//= require bootstrap-switch.min
//= require jquery.cookie
//= require noty/jquery.noty
//= require noty/layouts/top
//= require noty/themes/default
//= require dataTables/jquery.dataTables
//= require jquery.balloon.min
//= require jquery.timepicker.min
//= require fullcalendar
//= require moment.min
//= require pivot
//= require select2
//= require select2_locale_ja
//= require_tree .
//= require jquery_nested_form
//

// moment.js language configuration
// language : japanese (ja)
// author : LI Long : https://github.com/baryon

(function (factory) {
    factory(moment);
}(function (moment) {
    moment.lang('ja', {
        months : "1月_2月_3月_4月_5月_6月_7月_8月_9月_10月_11月_12月".split("_"),
        monthsShort : "1月_2月_3月_4月_5月_6月_7月_8月_9月_10月_11月_12月".split("_"),
        weekdays : "日曜日_月曜日_火曜日_水曜日_木曜日_金曜日_土曜日".split("_"),
        weekdaysShort : "日_月_火_水_木_金_土".split("_"),
        weekdaysMin : "日_月_火_水_木_金_土".split("_"),
        longDateFormat : {
            LT : "Ah時m分",
            L : "YYYY/MM/DD",
            LL : "YYYY年M月D日",
            LLL : "YYYY年M月D日LT",
            LLLL : "YYYY年M月D日LT dddd"
        },
        meridiem : function (hour, minute, isLower) {
            if (hour < 12) {
                return "午前";
            } else {
                return "午後";
            }
        },
        calendar : {
            sameDay : '[今日] LT',
            nextDay : '[明日] LT',
            nextWeek : '[来週]dddd LT',
            lastDay : '[昨日] LT',
            lastWeek : '[前週]dddd LT',
            sameElse : 'L'
        },
        relativeTime : {
            future : "%s後",
            past : "%s前",
            s : "数秒",
            m : "1分",
            mm : "%d分",
            h : "1時間",
            hh : "%d時間",
            d : "1日",
            dd : "%d日",
            M : "1ヶ月",
            MM : "%dヶ月",
            y : "1年",
            yy : "%d年"
        }
    });
}));
moment.lang("ja");

$(function(){

  $( ".datepicker" ).datetimepicker({lang:'ja',timepicker: false, format: "Y/m/d",
 i18n:{
  ja:{
   months:[ '1月','2月','3月','4月', '5月','6月','7月','8月', '9月','10月','11月','12月', ],
   dayOfWeek:[ "日", "月", "火", "水", "木", "金", "土", ]
  }
 }});

  $( ".datetimepicker" ).datetimepicker({lang:'ja',
 i18n:{
  ja:{
   months:[ '1月','2月','3月','4月', '5月','6月','7月','8月', '9月','10月','11月','12月', ],
   dayOfWeek:[ "日", "月", "火", "水", "木", "金", "土", ]
  }
 }});
  $('.dropdown-toggle').dropdown();
  $("[data-toggle=tooltip]").tooltip()
});

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("tr").hide();
}

function remove_periods(link, class_name) {
  $(link).prev("input[type=hidden]").val("1");
  $(".periods_field_" + class_name).hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(".add_fields").append(content.replace(regexp, new_id));
}

function submit_format(form, format) {
  $(form).submit(function(){
  $('<input />').attr('type', 'hidden')
   .attr('name', 'format')
   .attr('value', format)
   .appendTo(form);
  });
}
