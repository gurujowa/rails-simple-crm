class LeadComment < ActiveRecord::Base
  
  has_paper_trail 

  belongs_to :lead
  belongs_to :user

  validates :memo, presence: true  


end
