jQuery ->
  if(0 < $("#company_tag_list_form").size())
    $("#company_tag_list_form").select2
      width: "400px"
      tags: gon.tag_list

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
    url = "http://www.google.co.jp/search?q=" + $("#company_fulladdress").text() + " 郵便番号"
    window.open(url,"_blank")
  #GoogleMap検索
  $("#jump_map").on "click", ->
    url = "http://maps.google.co.jp/maps?q=" + $("#company_fulladdress").text()
    window.open(url,"_blank")

  #GoogleMap検索
  $("#jump_map2").on "click", ->
    url = "http://maps.google.co.jp/maps?q=" + $("#company_fulladdress2").text()
    window.open(url,"_blank")

    return false
