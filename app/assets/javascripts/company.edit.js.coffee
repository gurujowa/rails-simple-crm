jQuery ->
  $('.balloon').balloon({contents: $('#balloon_popup').clone().show(), position: "right"})

  $('form#new_task_form').submit ->
    $('#new_task_detail').show()
    $('#new_task_modal').modal('hide')    
    $('#td_task_name').text($("#task_name").val())
    $('#td_task_duedate').text($("#task_duedate").val())
    $('#td_task_assignee').text($("#task_assignee option:selected").text())
    $('#td_task_progress_id').text($("#task_progress_id option:selected").text())
    $('#td_task_note').text($("#task_note").val())

    $('#new_task_name').val($("#task_name").val())
    $('#new_task_type_id').val($("#task_type_id").val())
    $('#new_task_duedate').val($("#task_duedate").val())
    $('#new_task_assignee').val($("#task_assignee option:selected").val())
    $('#new_task_progress_id').val($("#task_progress_id option:selected").val())
    $('#new_task_note').val($("#task_note").val())

    return false

  $('.task-button').click -> 
    new NewTaskModal(this)


@task_change = (e) ->
  id = $(e).data("id")
  $.ajax '/task_status_change',
    type: 'GET'
    dataType: 'json'
    timeout: 1000
    data : {id: id, selected: $(e).children(':selected').val()}
    error:(jqXHR, textStatus, errorThrown) ->
      alert(errorThrown)
    success: (data, textStatus, jqXHR) ->
      noty(text: data["text"],type: data["type"],timeout: 2000)
      $('#task_progress_' + id).text(data["status_name"])
      $('#task_tr_' + id).removeClass()
      $('#task_tr_' + id).addClass(data["color"])
  return false

class NewTaskModal
  constructor:  (e)->
    now = new Date()
    nowms = now.getTime()
    $('#task_duedate').val($(e).data("due"))
    $('#task_name').val($(e).data("name"))
    $('#task_type_id').val($(e).data("type"))
    $('#task_assignee').val($(e).data("assignee"))
    $('#new_task_modal').modal()

