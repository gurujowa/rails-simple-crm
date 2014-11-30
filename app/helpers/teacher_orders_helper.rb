module TeacherOrdersHelper

  def teacher_order_status_button to
    if to.status == "draf"
      cl = "btn-default"
    elsif to.status == "active"
      cl = "btn-success"
    elsif to.status == "cancel"
      cl = "btn-danger"
    else
      cl = "btn-default"
    end
    return link_to to.status_text, teacher_order_path(to), class: "btn " + cl
  end

  def to_order_date model, attr
    date = model.read_attribute(attr)
    if date.present?
      return date.strftime('%Y-%m-%d')
    else
      img_tag =  check_m_img(false)
    end
    return img_tag.html_safe
  end

  def link_to_teacher_order_flg model,attr
    date = model.read_attribute(attr)
    if date.present?
      return date.strftime('%Y-%m-%d')
    else
      img_tag =  %Q{<img src='#{check_img_src(false)}' class='icon_teacher_order'/>}
    end
    return link_to img_tag.html_safe , :controller => "teacher_orders", :action => "flag", :remote => true, :id => model.id, :type => attr
  end

end
