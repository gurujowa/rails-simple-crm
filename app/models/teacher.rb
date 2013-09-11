class Teacher < ActiveRecord::Base
  
  def self.work_possible_hash
    {"仕事可能" => 0, "微妙" => 1, "仕事不可" => 2}
  end
  
  def name
    return last_kanji + " " + first_kanji
  end
end
