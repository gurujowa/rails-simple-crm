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
     name:
       value: "コース名"
     order_flg:
       value: "発注書"
     book_flg:
       value: "書籍送付"
     report_flg:
       value: "３点セット"
     end_form_flg:
       value: "支給申請"
     total_time:
       value: "コース時間"
     start_date:
       value: "開始日"
     end_date:
       value: "終了日"
     check: 
       value: "CH"
       define: {sWidth: "20px", bSortable: false, aTargets:["check"]}
   constructor: ->
     table = new DataTable(this.property, this.column)
     oTable = table.initTable()
     return table
 
 
window.CourseTable = CourseTable
