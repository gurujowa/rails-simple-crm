class CourseTask < ActiveRecord::Base
  belongs_to :course

  validates :course_id, presence: true  
  validates :title, presence: true  
  validates :start, presence: true  

end
