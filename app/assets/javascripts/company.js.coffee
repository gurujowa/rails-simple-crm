
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
    bStateSave:  true
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
  $("form.search_form").submit(->
    $.removeCookie("SpryMedia_DataTables_company_search", { path: '/companies/' })
    )
  $('.label-toggle-switch').on('switch-change', (e, data)-> 
      oTable = $('#company').dataTable()
      switch_column = data.el.context.id
      oTable.fnSetColumnVis( companytable.getColumnIndex(switch_column), data.value)
      $.cookie(data.el.context.id, data.value)
  )

