class Contact < ActiveRecord::Base
  belongs_to :company, :autosave => true
  
  def getCreatedBy()
    if self.created_by.present?
      User.find(self.created_by).name
    else
      return ""
    end
  end
  
end
