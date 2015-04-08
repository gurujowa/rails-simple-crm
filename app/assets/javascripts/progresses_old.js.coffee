app = angular.module("progress", []).controller "InvoiceController", () ->
  this.qty = 1
  this.cost = 2
  this.inCurr = 'EUR'
  this.currencies = ['USD', 'EUR', 'CNY']
  console.log this.currencies
  this.usdToForeignRates = 
    USD: 1
    EUR: 0.74
    CNY: 6.09

  this.total = (outCurr) ->
      return this.convertCurrency(this.qty * this.cost, this.inCurr, outCurr)

  this.convertCurrency = (amount, inCurr, outCurr) ->
    return amount * this.usdToForeignRates[outCurr] * 1 / this.usdToForeignRates[inCurr]
  this.pay = ->
    window.alert("Thanks!")
