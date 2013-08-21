class CompanyTable
   column:
     client_name:
       value: "会社名"
       define: {sWidth: "200px", aTargets:["client_name"]},
     status:
       value: "ステータス"
       define: {sWidth: "70px", aTargets:["status"]},
     client_person:
       value: "担当者"
     updated_at:
       value: "更新日"
     approach_day:
       value: "次回"
     sales_person:
       value: "営業マン"
     industry_id:
       value: "業種"
     bill:
       value: "売上見込"
     chance:
       value: "見込み度"
     lead:
       value: "データ元"
     created_by:
       value: "作成者"
     updated_by:
       value: "更新者"
     tel:
       value: "電話番号"
     fax:
       value: "FAX"
     contact:
       value: "コンタクト"
       define: {sWidth: "40%", bSortable: false ,aTargets:["contact"]}
     check: 
       value: "CH"
       define: {sWidth: "20px", bSortable: false, aTargets:["check"]}
   getColumnDefs: ->
     array = new Array
     for key, val of this.column
       if val.define == undefined
         val.define = {}
       if ($.cookie("switch-" + key) == "true")
         val.define.bVisible = true
       else
         val.define.bVisible = false

       array.push(val.define)
     return array
   switchState: ->
     for key, val of this.column
       if($.cookie('switch-' + key) == "true")
         $('#toggle-' + key).bootstrapSwitch('setState', true)
       else
         $('#toggle-' + key).bootstrapSwitch('setState', false)       

   getColumnIndex: (switch_column)->
     i = 0
     for key,val of this.column
       if (switch_column.indexOf(key) != -1)
         return i
       i++
     return false
   appendToggle: ->
     for key,val of this.column
       $("#toggle_table").append(
         $("<tr></tr>")
         .append($("<td></td>").text(val.value))
         .append($('<td></td>').html('<input id="switch-'+key+'" type="checkbox" checked>'))
       )
       $("#switch-" + key).wrap('<div id="toggle-'+key+'" class="label-toggle-switch make-switch switch-small" />').parent().bootstrapSwitch()
     
   appendDataTable: ->
     for key,val of this.column    
       $("#company thead:first tr:first").append("<th>" + val.value + "</th>")
       $("#company tbody:first tr:first").append("<td></td>")
   init: ->
     this.appendDataTable()
     this.appendToggle()
     this.switchState()


window.CompanyTable = CompanyTable