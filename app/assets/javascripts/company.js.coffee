# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
        $( ".datepicker" ).datepicker({dateFormat: 'yy-mm-dd'})
        $('#company').dataTable
          sPaginationType: "full_numbers"
          bJQueryUI: true
          sDom: '<"H"Tfr>t<"F"ip>'
          oTableTools:
            sSwfPath: "/assets/swf/copy_csv_xls_pdf.swf"
          bProcessing: true
          bServerSide: true
          bStateSave:  false
          bSort: true
          bDeferRender: true
          bAutoWidth: false
          sAjaxSource: $('#company').data('source')
          oLanguage: 
            "sLengthMenu": "表示行数 _MENU_ 件"
            "oPaginate": 
              "sNext": "次",
              "sPrevious": "前"
            "sInfo": "TOTAL_TOTAL_ _START_/_END_"
            "sSearch": "検索："
          aoColumnDefs:[
            sWidth: "50px", aTargets:["rank"]
            sWidth: "50%", bSortable: false ,aTargets:["contact"]
           ]

           