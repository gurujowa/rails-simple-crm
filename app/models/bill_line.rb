class BillLine < ActiveRecord::Base

  has_paper_trail 
  belongs_to :bill
end
