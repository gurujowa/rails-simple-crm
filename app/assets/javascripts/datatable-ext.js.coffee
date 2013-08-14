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


$.fn.dataTableExt.oApi.fnPagingInfo = (oSettings) ->
  iStart: oSettings._iDisplayStart
  iEnd: oSettings.fnDisplayEnd()
  iLength: oSettings._iDisplayLength
  iTotal: oSettings.fnRecordsTotal()
  iFilteredTotal: oSettings.fnRecordsDisplay()
  iPage: (if oSettings._iDisplayLength is -1 then 0 else Math.ceil(oSettings._iDisplayStart / oSettings._iDisplayLength)) + 1
  iTotalPages: (if oSettings._iDisplayLength is -1 then 0 else Math.ceil(oSettings.fnRecordsDisplay() / oSettings._iDisplayLength))


$.fn.dataTableExt.oApi.fnDisplayStart = (oSettings, iStart, bRedraw) ->
  bRedraw = true  if typeof bRedraw is "undefined"
  oSettings._iDisplayStart = iStart
  oSettings.oApi._fnCalculateEnd oSettings
  oSettings.oApi._fnDraw oSettings  if bRedraw