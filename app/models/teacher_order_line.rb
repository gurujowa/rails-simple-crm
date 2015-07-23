class TeacherOrderLine < ActiveRecord::Base

  has_paper_trail 
  belongs_to :teacher_order

  validates :invoice_date, presence: true
  validates :payment_date, presence: true
  validates :price, presence: true

end
