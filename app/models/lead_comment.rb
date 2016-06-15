class LeadComment < ActiveRecord::Base
  extend Enumerize
  
  has_paper_trail 
  belongs_to :lead
  belongs_to :user
  validates :memo, presence: true  
  enumerize :category, in: [:joseikin, :jimu]

end
