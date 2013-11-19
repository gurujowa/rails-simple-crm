class BillingPlan < ActiveRecord::Base
  extend Enumerize

  has_paper_trail 
  belongs_to :company
  has_many :billing_plan_lines, :dependent => :destroy  
  accepts_nested_attributes_for :billing_plan_lines, reject_if: :all_blank
  enumerize :status, in: [:draft, :completed], default: :draft
  
  validates :name, presence: true  
  validates :company_id, presence: true, numericality: true
  validates :tax_rate, presence: true, numericality: true
  validates :status, presence: true, inclusion: enumerized_attributes[:status].values

  def total_price
     price = 0
     self.billing_plan_lines.each do |c|
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
