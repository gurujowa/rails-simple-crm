# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  oTable = $('#teachers_datatable').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bStateSave:  true
    iDisplayLength: 100
    bSort: true
    bDeferRender: true
    bAutoWidth: false
    oLanguage: 
      sLengthMenu: "表示行数 _MENU_ 件"
      oPaginate: 
        "sNext": "次",
        "sPrevious": "前"
      sInfo: "TOTAL_TOTAL_ _START_/_END_"
      sSearch: "検索："
