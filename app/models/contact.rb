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
  
end
