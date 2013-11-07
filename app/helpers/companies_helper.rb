module CompaniesHelper
  def options_chance(default= nil)
    options_for_select([0,10,20,30,40,50,60,70,80,90,100], default)
  end


  def contactAsHtml(company)
    con_str = "<ul>".html_safe
    company.contacts.each do |d|
      if d.memo != nil
        con_str << "<li>".html_safe
        con_str.concat(d.memo)
        con_str << "</li>".html_safe
      end
    end
    con_str << "</ul>".html_safe
    return con_str
  end

end
  
