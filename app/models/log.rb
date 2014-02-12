# == Schema Information
#
# Table name: logs
#
#  id         :integer          not null, primary key
#  company_id :integer
#  status_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  created_by :string(255)
#

class Log < ActiveRecord::Base
  belongs_to :status
  belongs_to :company
end
