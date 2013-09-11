class Teacher < ActiveRecord::Base
  
  def self.work_possible_hash
    {:possible => 0, :subtle => 1, :impossible => 2}
  end

  
  def name
    return last_kanji + " " + first_kanji
  end
end
