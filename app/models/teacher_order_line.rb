class TeacherOrderLine < ActiveRecord::Base

  has_paper_trail 
  belongs_to :teacher_order

  validates :price, presence: true

end
