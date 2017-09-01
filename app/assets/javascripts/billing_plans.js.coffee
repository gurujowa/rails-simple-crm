# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  init_month_picker()
  $('#billing_plan_datatables').dataTable( {
        "lengthChange":     false,
        "pageLength":     100,
        "oSearch": {"sSearch": $('#billing_plan_datatables').data("search")}
    } );
$(document).on "nested:fieldAdded", (event) ->
  init_month_picker()

init_month_picker = ()->
  bl = $( ".billing_plan_month_picker" ).datetimepicker({viewMode: "months", format: "YYYY-MM"})
  bl.on "dp.update", (e)->
    bill_date = e.viewDate.endOf("month")
    $("#billing_plan_billing_plan_lines_attributes_#{$(this).data("id")}_bill_date").val(bill_date.format("YYYY-MM-DD"))
    accural_date = e.viewDate.add("months",1).endOf("month")
    $("#billing_plan_billing_plan_lines_attributes_#{$(this).data("id")}_accural_date").val(bill_date.format("YYYY-MM-DD"))
