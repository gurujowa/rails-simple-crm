# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  company_id :integer
#  memo       :text
#  created_by :string(255)
#  created_at :datetime
#  updated_at :datetime
#  con_type   :integer
#

class Contact < ActiveRecord::Base

  validates :memo, presence: true
  validates :con_type, presence: true
  belongs_to :company, :autosave => true
  
  def getCreatedBy()
    if self.created_by.present?
      User.find(self.created_by).name
    else
      return ""
    end
  end

  def type
    t = self.read_attribute(:con_type)
    return ContactType.id_search(t)
  end
  
end
