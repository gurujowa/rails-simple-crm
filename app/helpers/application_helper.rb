module ApplicationHelper
  
  def simple_date(time)
    if time.present?
      return time.strftime("%Y年%m月%d日 %H時%M分%S秒")
    end
  end
  
  def convert_min(minute)
    if(minute.present?)
     return (minute / 60).floor.to_s + "時間" + (minute % 60).floor.to_s + "分"
    else
     return 0
    end
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "btn btn-warning")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder, :delete_flg => false)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => "btn", :id => "add_field_button")
  end
  
  def check_img_src(bool)
    if bool == true
      return "/img/check.png"
    else
      return "/img/cross.png"
    end
  end
  
  
  def check_m_img(bool)
    if bool === true
      src =  "/img/check-m.png"
      order = "a"
    elsif bool === false
      src = "/img/cross-m.png"
      order = "b"
    else
      raise "type Error check_m_img"
    end   

    img_tag =  "<img src='" + src + "'/> <span style='display:none'>" + order + "</span>"    
    return img_tag.html_safe
  end

end
