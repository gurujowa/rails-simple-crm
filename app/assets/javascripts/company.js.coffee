$.fn.dataTableExt.oApi.fnReloadAjax = (oSettings, sNewSource, fnCallback, bStandingRedraw) ->
  oSettings.sAjaxSource = sNewSource  if sNewSource isnt `undefined` and sNewSource isnt null
  
  # Server-side processing should just call fnDraw
  if oSettings.oFeatures.bServerSide
    @fnDraw()
    return
  @oApi._fnProcessingDisplay oSettings, true
  that = this
  iStart = oSettings._iDisplayStart
  aData = []
  @oApi._fnServerParams oSettings, aData
  oSettings.fnServerData.call oSettings.oInstance, oSettings.sAjaxSource, aData, ((json) ->
    
    # Clear the old information from the table 
    that.oApi._fnClearTable oSettings
    
    # Got the data - add it to the table 
    aData = (if (oSettings.sAjaxDataProp isnt "") then that.oApi._fnGetObjectDataFn(oSettings.sAjaxDataProp)(json) else json)
    i = 0

    while i < aData.length
      that.oApi._fnAddData oSettings, aData[i]
      i++
    oSettings.aiDisplay = oSettings.aiDisplayMaster.slice()
    that.fnDraw()
    if bStandingRedraw is true
      oSettings._iDisplayStart = iStart
      that.oApi._fnCalculateEnd oSettings
      that.fnDraw false
    that.oApi._fnProcessingDisplay oSettings, false
    
    # Callback user function - for event handlers etc 
    fnCallback oSettings  if typeof fnCallback is "function" and fnCallback isnt null
  ), oSettings


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $( ".datepicker" ).datepicker({dateFormat: 'yy-mm-dd'})
  companytable = new CompanyTable $()
  companytable.init()
  
  $('#label').click( ->
    sData = $('input', oTable.fnGetNodes()).serialize()
    console.log(sData)
    if sData == "" 
      alert("チェックがありません")
      return false
    w = window.open()
    w.location.href = "/companies_pdf?" + sData
    return false 
  )
  
  $('#up_postsend').click( ->
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
  )
  
  oTable = $('#company').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    bStateSave:  false
    iDisplayLength: 100
    bSort: true
    bDeferRender: true
    bAutoWidth: false
    sAjaxSource: $('#company').data('source')
    oLanguage: 
      sLengthMenu: "表示行数 _MENU_ 件"
      oPaginate: 
        "sNext": "次",
        "sPrevious": "前"
      sInfo: "TOTAL_TOTAL_ _START_/_END_"
      sSearch: "検索："
    aoColumns: companytable.getColumnDefs()
  $('.label-toggle-switch').on('switch-change', (e, data)-> 
      oTable = $('#company').dataTable()
      switch_column = data.el.context.id
      oTable.fnSetColumnVis( companytable.getColumnIndex(switch_column), data.value)
      $.cookie(data.el.context.id, data.value)
  )
