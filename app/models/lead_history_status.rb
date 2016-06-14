class LeadHistoryStatus < ActiveRecord::Base
  extend Enumerize

  has_many :lead_history
  enumerize :progress, in: [:ing, :done, :forbidden, :conversion, :history], scope: true
  
end
