jQuery ->
  handson = document.getElementById "handson-trello-modal"
  if (handson != null)
    initHandson(handson)
  if(0 < $("#trello_task_list").size())
    authorizeTrello(false)
    Trello.get('/search',{query: $('#trello_task_list').data('lead'), card_list: true, card_board: true}, showTrelloList, errorTrello)
  $('#trello_authorize').click ->
    authorizeTrello(true)

@authorizeTrello =  (interactive)->
  Trello.authorize({
    name: "DEPPU trello",
    scope: { read: true, write: true },
    expiration: "never",
    interactive: interactive,
    success: ->
      console.log("Successful trello authentication")
    error: ->
      console.log("error trello authorize")
  })

@showTrelloList = (data) ->
  card_list = data.cards
  tbody = $('#trello_task_list tbody')
  jQuery.each card_list , () ->
    due = if this.due == null then "" else moment(this.due).format('LL')
    tbody.append("<tr><td data-id='#{this.idBoard}'><a href='https://trello.com/b/#{this.idBoard}'>#{this.board.name}</a></td><td data-id='#{this.idList}'>#{this.list.name}</td><td class='name'><a href='https://trello.com/c/#{this.id}' target='_blank'>#{this.name}</a></td><td class='due'>#{due}</td></tr>")

@errorTrello = (data) ->
  $("#trello_task_list").html("trelloの接続に失敗しました(#{data.responseText})")

@emptyValidator = (value, callback) ->
  console.log value
  if value != null then callback(false)  else callback(true)

@initHandson = (handson) ->
  data_object = []
  subsity_names = $.map gon.subsities, (n) ->  return n.name 
  hot = new Handsontable handson, 
    data: data_object
    dataSchema: {board: null,  name: null, due: null, memo: null}
    minSpareRows: 1
    colHeaders: true
    rowHeaders: true
    dropdownMenu: true
    manualColumnResize: true
    manualRowResize: true
    colHeaders: ['助成金','タスク名','期日','メモ']
    columns: [
      {data: "board", type: 'dropdown', source: subsity_names, width: 300}
      {data: "name", width: 300, validator: emptyValidator, allowInvalid: false}
      {data: "due", type:'date',dateFormat: 'YYYY/MM/DD', width: 120}
      {data: "memo", width: 300}
    ]
  
  Handsontable.Dom.addEvent document.getElementById('trello_task_add_button'), 'click', ->
    $.each data_object, ->
      new_card = 
        name: this.name
        desc: 'This is the description of our new card.'
        idList: this.list
        pos: 'top'
      Trello.post '/cards/',new_card, (data) ->
        console.log data
