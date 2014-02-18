json.extract! @datatables.getIData, :sEcho, :iTotalRecords, :iTotalDisplayRecords

comp = @datatables.getCompanies.map do |company|

[
        "<a href='"+ url_for(:action=>"edit", :id => company.id) + "'>"+ company.client_name.slice(0,25) + "</a>",
        company.status_name,
        company.active_st_text,
        company.client_person,
        company.updated_at.strftime('%Y/%m/%d'),
        company.salesman,
        company.industry.name,
        company.chance,
        company.campaign.name,
        get_user_name(company.created_by),
        get_user_name(company.updated_by),
        company.tel,
        company.fax,
        company.prefecture,
        company.city,
        company.address,
        company.building,
        contactAsHtml(company),
        '<input type="checkbox" name="check' + company.id.to_s + '" value="' + company.id.to_s + '">',
]
end

json.aaData comp
