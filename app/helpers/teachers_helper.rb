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
        Teacher.work_possible_hash.key(int)
    end
    
    def options_work_possible(default = nil)
        options_for_select(Teacher.work_possible_hash)    
    end

end
