class EstimateSubsity < ActiveRecord::Base
  has_paper_trail 

  belongs_to :estimate
  validates :name, presence: true
  validates :price, presence: true, numericality: {only_integer: true}

end
