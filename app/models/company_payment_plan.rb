# == Schema Information
#
# Table name: company_payment_plans
#
#  id         :integer          not null, primary key
#  duedate    :date             not null
#  reason     :text
#  memo       :text
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class CompanyPaymentPlan < ActiveRecord::Base
  belongs_to :company


  def self.build_for_params(plan_params, id)
    self.new(duedate: plan_params[:payment], reason: plan_params[:payment_reason],company_id: id)
  end
end

