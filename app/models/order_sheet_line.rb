class OrderSheetLine < ActiveRecord::Base

  has_paper_trail 
  belongs_to :order_sheet

  validates :price, presence: true

end
