module OrderSheetsHelper

  def order_sheet_send_to_selectize_option(teachers,send_to = nil)
    list = teachers.map{|t| t.short_name}
    if send_to.present?
      return list.push(@order_sheet.send_to).uniq
    else
      return list
    end

  end

  def period_order_status_button(period, click: :path)
    if period.order_status == :no_sheet
      link_to "未発行", new_order_sheet_path(period_id: period.id), class: "btn btn-default"
    else
      order_sheet_status_button(period.order_sheet, click: click)
    end
  end

  def order_sheet_status_button(to, click: :path)
    if to.status == "draft"
      cl = "btn-default"
    elsif to.status == "active"
      cl = "btn-success"
    elsif to.status == "cancel"
      cl = "btn-danger"
    else
      cl = "btn-default"
    end
    if click == :path
      return link_to to.status_text, order_sheet_path(to), class: "btn " + cl
    elsif click == :toggle
      return link_to to.status_text, order_sheet_path(to, format: :js), remote: true,id: "order_sheet_#{to.id}", class: "btn " + cl
    else
      raise "click is invalid"
    end
  end

end
