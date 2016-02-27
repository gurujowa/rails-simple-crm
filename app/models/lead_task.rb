class LeadTask < ActiveRecord::Base
  belongs_to :lead
  belongs_to :lead_subsity

  validates :due_date, presence: true
  validates :name, presence: true  
end
