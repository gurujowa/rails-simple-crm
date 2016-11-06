module CoursesHelper

  def period_price_text(p)
    if p.train_cost.present?
      return "合計#{number_to_currency(p.price + p.train_cost)}<br>(謝金#{number_to_currency(p.price)})<br>(交通費#{number_to_currency(p.train_cost)})".html_safe
    else
      return number_to_currency p.price
    end
  end

  def course_calendar_color(period)
    if period.resume_complete_flag == true
      return "course-calendar-complete"
    elsif period.checked_task.include?("check_resume")
      return "course-calendar-checked"
    else
      return "course-calendar-initial"
    end
  end

  def ordered_period_clip(period)
    if period.order_avail == "unnecessary" or period.order_sheet_active?
      return ""
    else
     return 0x1F4CE.chr("UTF-8")
    end
  end

  def check_course_img(course,type)
    src = check_img_src(course.read_attribute(type))

    img_tag =  "<img src='" + src + "' id='icon_" + type + "_" + course.id.to_s + "' /><span style='display:none'>" + course.read_attribute(type).to_s + "</span>"
    tag = link_to img_tag.html_safe, :controller => "courses", :action => "up_bool", :remote => true, :id => course.id, :type => type
    return tag.html_safe    
  end
  
end
