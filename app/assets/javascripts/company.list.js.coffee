# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  oTable = new CompanyTable()
  
  $('#label').click ->
    sData = $('input', oTable.fnGetNodes()).serialize()
    console.log(sData)
    if sData == "" 
      alert("チェックがありません")
      return false
    w = window.open()
    w.location.href = "/companies_pdf?" + sData
    return false 
  
  $('#up_postsend').click ->
    sData = $('input', oTable.fnGetNodes()).serialize()
    console.log(sData)
    if sData == "" 
      alert("チェックがありません")
      return false
    $.ajax '/up_postsend',
      type: 'GET'
      dataType: 'json'
      timeout: 1000
      data : sData
      error:(jqXHR, textStatus, errorThrown) ->
        alert(errorThrown)
      success: (data, textStatus, jqXHR) ->
        noty(
          text: data["text"]
          type: data["type"]
          timeout: 2000
        )
        oTable.fnReloadAjax()
    return false 
  
  $("form.search_form").submit(->
    $.removeCookie("SpryMedia_DataTables_company_search", { path: '/companies/' })
    return true
  )
