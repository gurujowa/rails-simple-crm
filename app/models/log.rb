class Log < ActiveRecord::Base
  belongs_to :status
  belongs_to :company
end
