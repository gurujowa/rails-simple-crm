# == Schema Information
#
# Table name: company_contract_plans
#
#  id         :integer          not null, primary key
#  duedate    :date             not null
#  reason     :text
#  memo       :text
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class CompanyContractPlan < ActiveRecord::Base
  belongs_to :company

  validates :duedate, presence: true
  validates :reason, presence: true
end
