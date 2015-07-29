module OrderSheetsHelper

  def order_sheet_status_button to
    if to.status == "draft"
      cl = "btn-default"
    elsif to.status == "active"
      cl = "btn-success"
    elsif to.status == "cancel"
      cl = "btn-danger"
    else
      cl = "btn-default"
    end
    return link_to to.status_text, order_sheet_path(to), class: "btn " + cl
  end

end
