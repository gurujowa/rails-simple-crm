class DataTable
   constructor: (property, column) ->
     this.property = property
     this.column = column
     this.init()
   appendHeader: ->
     for key,val of this.column    
       $(this.property.datatable + " thead:first tr:first").append("<th>" + val.value + "</th>")
   appendToggle: ->
     for key,val of this.column
       switch_id = "switch-" + this.property.table_id + '-' +key
       toggle_id = "toggle-" + this.property.table_id + '-' + key
       $(this.property.toggle_table).append(
         $("<tr></tr>")
         .append($("<td></td>").text(val.value))
         .append($('<td></td>').html('<input id="' + switch_id + '" type="checkbox" checked>'))
       )
       $("#" + switch_id)
         .wrap('<div id="' + toggle_id + '" class="' + this.property.table_id  +  '-toggle-switch make-switch switch-small" />')
         .parent().bootstrapSwitch()
   switchState: ->
     for key, val of this.column 
       toggle_id = "#toggle-" + this.property.table_id + '-' + key
       if(this.getCookieId(key) == "true" or val.defaultState == true)
         $(toggle_id).bootstrapSwitch('setState', true)
       else
         $(toggle_id).bootstrapSwitch('setState', false)

   init: ->
     this.appendToggle()
     this.appendHeader()
     this.switchState()
     this.switchLive()

   getCookieId: (key) ->
     return $.cookie("switch-" + this.property.table_id + '-' +key)
   getColumnDefs: ->
     array = new Array
     for key, val of this.column
       if val.define == undefined
         val.define = {}
       if (this.getCookieId(key) == "true" or val.defaultState == true)
         val.define.bVisible = true
       else
         val.define.bVisible = false
       array.push(val.define)
     return array
   getColumnIndex: (switch_column)->
     i = 0
     for key,val of this.column
       if (switch_column.indexOf(key) != -1)
         return i
       i++
     return false
   switchLive: ->
    _this = this
    $('.' + _this.property.table_id + '-toggle-switch').on 'switch-change', (e, data)-> 
       oTable = $(_this.property.datatable).dataTable()
       switch_column = data.el.context.id
       oTable.fnSetColumnVis( _this.getColumnIndex(switch_column), data.value)
       $.cookie(data.el.context.id, data.value)
   initTable: (prop = null)->
     hash =
       sPaginationType: "full_numbers"
       bJQueryUI: true
       aaSorting: [[ 1, "asc" ]]
       bProcessing: true
       bStateSave:  false
       iDisplayLength: 100
       bSort: true
       bDeferRender: true
       bAutoWidth: false
       aoColumns: this.getColumnDefs()
       oLanguage: 
          sLengthMenu: "表示行数 _MENU_ 件"
          oPaginate: 
            "sNext": "次",
            "sPrevious": "前"
          sInfo: "TOTAL_TOTAL_ _START_/_END_"
          sSearch: "検索："
     m_hash = $.extend(hash,prop)
     oTable = $(this.property.datatable).dataTable(m_hash)
     return oTable     


window.DataTable = DataTable
