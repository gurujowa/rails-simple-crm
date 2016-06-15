class LeadHistoryStatus < ActiveRecord::Base
  extend Enumerize

  has_many :lead_history
  enumerize :progress, in: [:ing, :done, :conversion, :history], scope: true
  
end
