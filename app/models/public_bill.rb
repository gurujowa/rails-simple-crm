class PublicBill < ActiveRecord::Base
  has_paper_trail 
  has_many :public_bill_lines, :dependent => :destroy
  accepts_nested_attributes_for :public_bill_lines

  def total_price
     price = 0
     self.public_bill_lines.each do |c|
       price += c.total_price
     end
     return price
  end
end
