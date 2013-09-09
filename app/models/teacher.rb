class Teacher < ActiveRecord::Base
  def name
    return last_kanji + " " + first_kanji
  end
end
