class CompanyTable
  property:
    toggle_table: "#companies_toggle_table"
    datatable: "#companies_datatable"
    table_id: "companies"
  column:
    client_name:
      value: "会社名"
      defaultState: true
      define: {sWidth: "200px", aTargets:["client_name"]},
    status:
      value: "進捗ステータス"
      defaultState: true
      define: {sWidth: "70px", aTargets:["status"]},
    active_st:
      value: "状態ステータス"
      defaultState: true
    client_person:
      value: "担当者"
    updated_at:
      value: "更新日"
    sales_person:
      value: "営業マン"
      defaultState: true
      define: { bSortable: false}
    industry_id:
      value: "業種"
    chance:
      value: "見込み度"
    campaign_id:
      value: "新規獲得元"
    created_by:
      value: "作成者"
    updated_by:
      value: "更新者"
    tel:
      value: "電話番号"
    fax:
      value: "FAX"
    prefecture:
      value: "都道府県"
      defaultState: true
    city:
      value: "市町村区"
      defaultState: true
    address:
      value: "住所"
      define: { bSortable: false}
    building:
      value: "ビル名"
      define: { bSortable: false}
    contact:
      value: "コンタクト"
      define: {sWidth: "40%", bSortable: false ,aTargets:["contact"]}
      defaultState: true
    check: 
      value: "CH"
      define: {sWidth: "20px", bSortable: false, aTargets:["check"]}
      defaultState: true

  constructor: ->
    table = new DataTable(this.property, this.column)
    oTable = table.initTable({sAjaxSource: $(this.property.datatable).data('source'), bServerSide: true})
    return oTable


window.CompanyTable = CompanyTable
