
jQuery ->
  $('.balloon').balloon({contents: $('#balloon_popup').clone().show(), position: "right"})
  $("#edit_tab a[data-toggle=\"tab\"]").on "shown", (e) -> 
    localStorage.setItem "lastEditTab", $(e.target).attr("id")
  lastTab = localStorage.getItem("lastEditTab")
  $("#" + lastTab).tab "show"  if lastTab

  $("#edit_contact_tab a[data-toggle=\"tab\"]").click (e) -> 
    e.preventDefault()
    $(this).tab "show"

  #郵便番号検索
  $("#jump_zip").on "click", ->
    url = "http://www.google.co.jp/search?q=" + $("#company_prefecture").val() + $("#company_city").val() + $("#company_address").val() + " 郵便番号"
    window.open(url,"_blank")
  #GoogleMap検索
  $("#jump_map").on "click", ->
    url = "http://maps.google.co.jp/maps?q=" + $("#company_prefecture").val() + $("#company_city").val() + $("#company_address").val()
    window.open(url,"_blank")

  #GoogleMap検索
  $("#jump_map2").on "click", ->
    url = "http://maps.google.co.jp/maps?q=" + $("#company_prefecture2").val() + $("#company_city2").val() + $("#company_address2").val()
    window.open(url,"_blank")

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
    timeout: 3000
    data : {id: id, selected: $(e).children(':selected').val()}
    error:(jqXHR, textStatus, errorThrown) ->
      alert(errorThrown)
    success: (data, textStatus, jqXHR) ->
      noty(text: data["text"],type: data["type"],timeout: 5000)
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

