class LeadHistory < ActiveRecord::Base
  belongs_to :lead
  belongs_to :lead_history_status
  belongs_to :user

  validates :approach_day, presence: true  
  validates :user_id, presence: true  
  validates :lead_history_status_id, presence: true  

end
