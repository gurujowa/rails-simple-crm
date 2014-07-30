module CoursesHelper

  def check_course_img(course,type)
    src = check_img_src(course.read_attribute(type))

    img_tag =  "<img src='" + src + "' id='icon_" + type + "_" + course.id.to_s + "' /><span style='display:none'>" + course.read_attribute(type).to_s + "</span>"
    tag = link_to img_tag.html_safe, :controller => "courses", :action => "up_bool", :remote => true, :id => course.id, :type => type
    return tag.html_safe    
  end
  
  def check_period_img(period,type)
    src = check_img_src(period.object.read_attribute(type))
    img_tag =  "<img src='" + src + "' id='icon_period_" + type + "_" + period.object.id.to_s + "' class='period_img' />"
    
    return img_tag.html_safe + period.hidden_field(type, :class => "period_hidden") 
  end

  def link_to_remove_periods(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_periods(this, " + f.index.to_s + ")", :class => "btn btn-warning")
  end

  
  def time_input(builder, name, required)
    value = builder.object.read_attribute(name)
    
    hash = {:class=>name + "picker course_timepicker form-control input-sm"}
    hash.store(:required, true) if required == true
    hash.store(:value, value.strftime("%H:%M")) if value.present?
    
    builder.text_field(name , hash)
  end
  

end
