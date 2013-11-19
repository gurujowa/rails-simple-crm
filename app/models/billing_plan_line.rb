class BillingPlanLine < ActiveRecord::Base
  belongs_to :billing_plan

  validates :due_date, presence: true  
  validates :bill_date, presence: true  
  validates :accural_date, presence: true  
  validates :quantity, presence: true , 
    numericality: {only_integer: true, greater_than: 0}
  validates :unit_price, presence: true,  
    numericality: {only_integer: true, greater_than: 0}

  def total_price
    unit_price.to_i * quantity.to_i
  end

end
