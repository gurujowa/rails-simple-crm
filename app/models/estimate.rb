class Estimate < ActiveRecord::Base
  belongs_to :company
  has_many :estimate_lines, :dependent => :destroy
  accepts_nested_attributes_for :estimate_lines, :allow_destroy => true

  validates :title, presence: true
  validates :company_id, presence: true
  validates :tax_rate, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 10}

  def total_price
     price = 0
     self.estimate_lines.each do |c|
       price += c.total_price
     end
     return price
  end

  def tax_price
     return total_price * (tax_rate.to_f * 0.01)
  end

  def tax_include_price
     return total_price + tax_price
  end
end
