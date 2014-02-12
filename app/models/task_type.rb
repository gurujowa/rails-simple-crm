# == Schema Information
#
# Table name: task_types
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  default_due      :integer
#  default_assignee :integer
#  tag              :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class TaskType < ActiveRecord::Base
  
  def getDueDate
    if (self.default_due.present?)
      return self.default_due.business_day.from_now.strftime("%Y-%m-%d")
    else
      return nil
    end
  end
  
  def getDefaultAssignee(current_user)
    if self.default_assignee.present?
      return self.default_assignee
    else
      return current_user.id
    end
  end
end
