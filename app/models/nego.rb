class Nego < ActiveRecord::Base

  has_paper_trail 
  belongs_to :company
  belongs_to :user
end
