class LeadHistory < ActiveRecord::Base
  has_paper_trail 
  belongs_to :lead
  belongs_to :lead_history_status
  belongs_to :user

  validates :approach_day, presence: true  
  validates :user_id, presence: true  
  validates :lead_history_status_id, presence: true  

  reportable :tel, :aggregation => :count, :date_column => :approach_day, :live_data => true
  scope  :exclude_initial, lambda{ where('created_at > ?', DateTime.new(2014,06,27))}
end
