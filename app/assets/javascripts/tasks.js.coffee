# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('.task-button').click -> 
      new NewTaskModal(this)
    
    oTable = $('#tasks_datatable').dataTable
      sPaginationType: "full_numbers"
      bJQueryUI: true
      bProcessing: true
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

class NewTaskModal
  constructor:  (e)->
    now = new Date()
    nowms = now.getTime()
    console.log(e)
    $('#task_duedate').val($(e).data("due"))
    $('#task_name').val($(e).data("name"))
    $('#task_type_id').val($(e).data("type"))
    $('#task_assignee').val($(e).data("assignee"))
    $('#new_task').modal()
