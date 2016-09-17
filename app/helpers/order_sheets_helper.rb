module OrderSheetsHelper

  def select_order_sheet_periods(id)
    return Period.includes([{course: :lead},:teacher]).order(:day).where(order_sheet_id: [nil, id])
  end

  def avail_button(period)
    case period.order_avail
    when "ng"
      button_class = "btn btn-default"
    when "ok"
      button_class = "btn btn-success"
    when "unnecessary"
      button_class = "btn btn-info"
    else
      raise "#{period.order_avail } is invalid "
    end
      return "<div data-name='order_avail' data-pk='#{period.id}' data-value='#{period.order_avail}' class='#{button_class} order-avail-editable'>#{period.order_avail_i18n}</a>".html_safe
  end

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
