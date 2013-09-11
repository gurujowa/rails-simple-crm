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
       flag = Teacher.work_possible_hash.key(int)
       if (flag == :possible)
         return "<img src='/img/check.png' /><span style='display:none'>a</span>".html_safe
       elsif (flag == :subtle)
         return "<img src='/img/question.png' /><span style='display:none'>b</span>".html_safe
       elsif (flag == :impossible)
         return "<img src='/img/cross.png' /><span style='display:none'>c</span>".html_safe
       else
         raise "正しいwork_possible ではありません。 int = " + int
       end
    end
    
    def options_work_possible(default = nil)
        options_for_select(work_possible_string)    
    end

    def work_possible_string
      {"◯" => 0, "△" => 1, "✗" => 2}
    end

end
