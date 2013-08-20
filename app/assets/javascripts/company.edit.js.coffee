jQuery ->
  $('.balloon').balloon({contents: $('#balloon_popup').clone().show(), position: "right"})


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