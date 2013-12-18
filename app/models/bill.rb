class Bill < ActiveRecord::Base

  has_paper_trail 
  belongs_to :billing_plan_line

  has_many :bill_lines, :dependent => :destroy 
  accepts_nested_attributes_for :bill_lines, reject_if: :all_blank
  validates :name, presence: true  
  validates :duedate, presence: true  
  validates :billing_plan_line_id, presence: true, numericality: true, uniqueness: true

  def company_name
    self.billing_plan_line.billing_plan.company.client_name
  end
end
