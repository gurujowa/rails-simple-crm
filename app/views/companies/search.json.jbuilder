json.extract! @datatables.getIData, :sEcho, :iTotalRecords, :iTotalDisplayRecords

comp = @datatables.getCompanies.map do |company|
if company.sales_person.present?
  sales_person = get_user_name(company.sales_person)
else
  sales_person = ""
end

[
        "<a href='"+ url_for(:action=>"edit", :id => company.id) + "'>"+ company.client_name.slice(0,25) + "</a>",
        get_status_name(company.status_id),
        company.client_person,
        company.updated_at.strftime('%Y/%m/%d'),
        company.approach_day,
        sales_person,
#        company.created_by,
#        company.updated_by,
        company.getContact
]
end

json.aaData comp