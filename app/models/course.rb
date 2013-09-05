class Course < ActiveRecord::Base
  belongs_to :company
  has_many :periods, :dependent => :destroy
  accepts_nested_attributes_for :periods,:allow_destroy => true, :reject_if => lambda { |a| a[:day].blank? }
  
  validates :name, presence: true  
  validates :company_id, presence: true  

end
