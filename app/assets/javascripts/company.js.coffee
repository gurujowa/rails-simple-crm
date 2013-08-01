`
$.fn.dataTableExt.oApi.fnReloadAjax = function ( oSettings, sNewSource, fnCallback, bStandingRedraw )
{
    if ( sNewSource !== undefined && sNewSource !== null ) {
        oSettings.sAjaxSource = sNewSource;
    }
 
    // Server-side processing should just call fnDraw
    if ( oSettings.oFeatures.bServerSide ) {
        this.fnDraw();
        return;
    }
 
    this.oApi._fnProcessingDisplay( oSettings, true );
    var that = this;
    var iStart = oSettings._iDisplayStart;
    var aData = [];
 
    this.oApi._fnServerParams( oSettings, aData );
 
    oSettings.fnServerData.call( oSettings.oInstance, oSettings.sAjaxSource, aData, function(json) {
        /* Clear the old information from the table */
        that.oApi._fnClearTable( oSettings );
 
        /* Got the data - add it to the table */
        var aData =  (oSettings.sAjaxDataProp !== "") ?
            that.oApi._fnGetObjectDataFn( oSettings.sAjaxDataProp )( json ) : json;
 
        for ( var i=0 ; i<aData.length ; i++ )
        {
            that.oApi._fnAddData( oSettings, aData[i] );
        }
         
        oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
 
        that.fnDraw();
 
        if ( bStandingRedraw === true )
        {
            oSettings._iDisplayStart = iStart;
            that.oApi._fnCalculateEnd( oSettings );
            that.fnDraw( false );
        }
 
        that.oApi._fnProcessingDisplay( oSettings, false );
 
        /* Callback user function - for event handlers etc */
        if ( typeof fnCallback == 'function' && fnCallback !== null )
        {
            fnCallback( oSettings );
        }
    }, oSettings );
};
`
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
        $( ".datepicker" ).datepicker({dateFormat: 'yy-mm-dd'})
        $('#label').click( ->
          sData = $('input', oTable.fnGetNodes()).serialize()
          console.log(sData)
          if sData == "" 
            alert("チェックがありません")
            return false
          w = window.open()
          w.location.href = "/companies_pdf?" + sData
          return false 
        )
        
        $('#up_postsend').click( ->
          sData = $('input', oTable.fnGetNodes()).serialize()
          console.log(sData)
          if sData == "" 
            alert("チェックがありません")
            return false
          $.ajax '/up_postsend',
            type: 'GET'
            dataType: 'json'
            timeout: 1000
            data : sData
            error:(jqXHR, textStatus, errorThrown) ->
              alert(errorThrown)
            success: (data, textStatus, jqXHR) ->
              noty(
                text: data["text"]
                type: data["type"]
                timeout: 2000
              )
              oTable.fnReloadAjax()
          return false 
        )
        
        oTable = $('#company').dataTable
          sPaginationType: "full_numbers"
          bJQueryUI: true
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
            {sWidth: "200px", aTargets:["client_name"]},
            {sWidth: "70px", aTargets:["rank"]},
            {sWidth: "50%", bSortable: false ,aTargets:["contact"]},
            {sWidth: "20px", bSortable: false, aTargets:["check"]}
           ]
         