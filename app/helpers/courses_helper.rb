module CoursesHelper

  def check_img(course,type)
    src = check_img_src(course.read_attribute(type))

    img_tag =  "<img src='" + src + "' id='icon_" + type + "_" + course.id.to_s + "' />"
    tag = link_to img_tag.html_safe, :controller => "courses", :action => "up_bool", :remote => true, :id => course.id, :type => type
    return tag.html_safe    
  end
  
  def check_img_src(bool)
    if bool == true
      return "/img/check.png"
    else
      return "/img/cross.png"
    end
  end
end
