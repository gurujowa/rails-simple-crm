module TeachersHelper
    def options_teachers(default= nil)
        teachers = Teacher.where(work_possible: 0..1).order("last_kana ASC, first_kana ASC")
        options = options_from_collection_for_select(teachers, :id, :name, :selected=> default)
        return options
    end

    def check_teacher_img(teacher,type)
      src = check_img_src(teacher.read_attribute(type))
      img_tag =  "<img src='" + src + "' id='icon_teacher_" + type + "_" + teacher.id.to_s + "' />"
      tag = link_to img_tag.html_safe, :controller => "teachers", :action => "up_bool", :remote => true, :id => teacher.id, :type => type
      return tag.html_safe    
    end


    
    def get_work_possible(int)
        w = {"仕事可能" => 0, "微妙" => 1, "仕事不可" => 2}
        return w.key(int)     
    end
    
    def options_work_possible(default = nil)
        w = {"仕事可能" => 0, "微妙" => 1, "仕事不可" => 2}
        options = options_for_select(w)
        return options
      
    end

end
