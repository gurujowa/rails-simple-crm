# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org
jQuery ->
  if(0 < $("#lead_tag_list").size())
    $("#lead_tag_list").select2
      width: "400px"
      tags: gon.tag_list
  $("#lead_tag_list_search").select2
    width: "400px"

  $('#index_all_checkbox').on 'change', ->
    $('input[name=leads]').prop('checked', this.checked)

  if(0 < $(".lead_editable").size())
    $(".lead_editable").editable
      url: "/leads/up_column"
      pk: gon.pk

  if(0 < $(".lead_interview_editable").size())
    $(".lead_interview_editable").editable
      url: "/lead_interviews/" + gon.pk
      ajaxOptions:
        type: "PUT"
      pk: gon.pk

  if(0 < $(".lead_comment_editable").size())
    $(".lead_comment_editable").editable
      url: $(this).data("url")
      ajaxOptions:
        type: "put"
      pk: $(this).data("pk")

  if(0 < $("#lead_sex_editable").size())
    $("#lead_sex_editable").editable
      url: "/leads/up_column"
      method: "POST"
      pk: gon.pk
      type: "select"
      name: "sex"
      title: "性別を選択してください"
      source: gon.sex_list

  $('#leads_csv_button').click ->
    reloadWithFormat('csv')

  $('#leads_address_label').click ->
    sData = $('input.leads_index_checkbox').serialize()
    if sData == "" 
      alert("チェックがありません")
      return false
    w = window.open()
    w.location.href = "/leads/address.csv?" + sData
    return false 

  if(0 < $("#lead-show-tab").size())
    pk = $("#lead-show-tab").data("pk")
    $('#lead-show-tab a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
      localStorage.setItem('lead-tab-'+ pk, $(this).attr('href'))
    lastTab = localStorage.getItem('lead-tab-' + pk)
    if (lastTab) 
      $('#lead-show-tab a[href="' + lastTab + '"]').tab('show')

@reloadWithFormat = (format) ->
  url = "#{location.protocol}//#{location.host}/leads.#{format}#{location.search}"
  location.href = url
