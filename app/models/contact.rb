class Contact < ActiveRecord::Base
  belongs_to :company, :autosave => true
  
end
