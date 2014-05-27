class CourseTable
   property:
     toggle_table: "#courses_toggle_table"
     datatable: "#courses_datatable"
     table_id: "courses"
   column:
     id:
       value: "id"
     client_name:
       value: "会社名"
       define: {sWidth: "200px", aTargets:["client_name"]},
       defaultState: true
     name:
       value: "コース名"
       defaultState: true
     order_flg:
       value: "発注書"
       defaultState: true
     book_flg:
       value: "書籍送付"
       defaultState: true
     attendee_table_flg:
       value: "出席票作成"
       defaultState: true
     reception_seal_flg:
       value: "窓口受領印"
       defaultState: true
     cert_seal_flg:
       value: "労働局受領印"
       defaultState: true
     end_form_flg:
       value: "支給申請"
       defaultState: true
     diploma_flg:
       value: "修了書"
       defaultState: true
     total_time:
       value: "コース時間"
       defaultState: true
     start_date:
       value: "開始日"
       defaultState: true
     end_date:
       value: "終了日"
       defaultState: true
     check: 
       value: "CH"
       define: {sWidth: "20px", bSortable: false, aTargets:["check"]}
       defaultState: true
   constructor: ->
     table = new DataTable(this.property, this.column)
     oTable = table.initTable()
     return table
 
 
window.CourseTable = CourseTable
