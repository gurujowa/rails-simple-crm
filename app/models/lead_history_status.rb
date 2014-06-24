class LeadHistoryStatus < ActiveRecord::Base
  extend Enumerize

  enumerize :progress, in: [:ing, :done, :forbidden]
  
end
