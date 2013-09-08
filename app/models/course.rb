class Course < ActiveRecord::Base
  belongs_to :company
  has_many :periods, :dependent => :destroy
  accepts_nested_attributes_for :periods,:allow_destroy => true
  
  validates :name, presence: true  
  validates :company_id, presence: true  


  def getTotalTime
    periods = self.periods
    total = 0
    
    periods.each do |p|
      total += p.getTotal
    end
    
    total
  end
end
