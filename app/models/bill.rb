# == Schema Information
#
# Table name: bills
#
#  id                   :integer          not null, primary key
#  name                 :string(255)      not null
#  duedate              :date             not null
#  billing_plan_line_id :integer          not null
#  bill_flg             :boolean          default(FALSE), not null
#  payment_flg          :boolean          default(FALSE), not null
#  memo                 :text
#  created_at           :datetime
#  updated_at           :datetime
#

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


  def total_price
     price = 0
     self.bill_lines.each do |c|
       price += c.total_price
     end
     return price
  end

end
