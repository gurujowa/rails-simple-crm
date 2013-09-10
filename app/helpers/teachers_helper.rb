module TeachersHelper
    def options_teachers(default= nil)
        teachers = Teacher.where(work_possible: 0..1).order("last_kana ASC, first_kana ASC")
        options = options_from_collection_for_select(teachers, :id, :name, :selected=> default)
        return options
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
