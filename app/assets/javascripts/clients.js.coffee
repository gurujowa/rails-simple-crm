# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $(document).on 'click','.clients_tab_add_field a' ,->
      pk = $("#company_edit_clients_tab_content div.tab-pane:last").data("pk")
      $("ul#company_edit_clients_tab").append('<li><a id="company_edit_client_tab_'+ pk + '" href="#company_edit_client_'+pk+'" data-toggle="tab">新しい連絡先</a></li>')
      $("#company_edit_client_tab_" + pk).tab('show')
    $('#company_edit_clients_tab a').click (e) ->
      e.preventDefault()
      $(this).tab('show')
