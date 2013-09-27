module TeacherOrdersHelper

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
