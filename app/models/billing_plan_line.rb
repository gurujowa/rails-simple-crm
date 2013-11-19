class BillingPlanLine < ActiveRecord::Base

  has_paper_trail 
  belongs_to :billing_plan

  validates :bill_date, presence: true  
  validates :accural_date, presence: true  
  validates :price, presence: true,  
    numericality: {only_integer: true, greater_than: 0}

end
