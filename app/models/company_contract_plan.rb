class CompanyContractPlan < ActiveRecord::Base
  belongs_to :company

  validates :duedate, presence: true
  validates :reason, presence: true

  def self.build_for_params(plan_params, id)
    self.new(duedate: plan_params[:contract], reason: plan_params[:contract_reason],company_id: id)
  end
end
