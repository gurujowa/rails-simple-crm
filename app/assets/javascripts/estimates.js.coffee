# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("input[name='estimate[tax_rate]']").on 'change', ->
    $('#estimate_tax_rate').text($(this).val())
    calcTotalPrice()

  $(document).on 'change', '.estimate_lines_trigger', ->
    unit_price = $(this).parent().parent().find('.estimate_line_unit_price').val()
    quantity = $(this).parent().parent().find('.estimate_line_quantity').val()
    $(this).parent().parent().find('.estimate_line_total_price').html( "<span class='estimate_line_calc'>" + (unit_price * quantity) + "</span>円")
    calcTotalPrice()



calcTotalPrice = ->
  total_price = 0
  tax_rate = parseInt($("#estimate_tax_rate").text())
  $("span.estimate_line_calc").each ->
    total_price += parseInt( $(this).text() )

  $("#td_estimate_total_price").text( total_price + "円")
  tax_price = total_price * tax_rate * 0.01
  $("#td_estimate_tax_price").text( tax_price + "円")
  $("#td_estimate_tax_include_price").text( (tax_price + total_price) + "円" )
