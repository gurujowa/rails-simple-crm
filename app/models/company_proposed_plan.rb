class CompanyProposedPlan < ActiveRecord::Base
  belongs_to :company

  validates :duedate, presence: true
  validates :reason, presence: true
end
