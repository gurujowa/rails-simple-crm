class EstimateLine < ActiveRecord::Base

  has_paper_trail 
  belongs_to :estimate

  validates :unit_price, presence: true
  validates :name, presence: true
  validates :quantity, presence:true

  def total_price
    unit_price.to_i * quantity.to_i
  end
end
