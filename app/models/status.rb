# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  rank       :string(255)
#  active     :boolean
#  created_at :datetime
#  updated_at :datetime
#  dm_st      :boolean          default(FALSE)
#

class Status < ActiveRecord::Base
end
