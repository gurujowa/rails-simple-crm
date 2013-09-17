class TeacherOrder < ActiveRecord::Base
  has_many :courses
  belongs_to :teacher

end
