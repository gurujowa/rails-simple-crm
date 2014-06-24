class Lead < ActiveRecord::Base
  belongs_to :user
  has_many :lead_histories

  default_scope :order => 'created_at DESC'
  acts_as_indexed :fields => [:full_address, :name, :tel, :fax, :email, :person_name, :person_kana, :zip_code]

  def next_approach_day
    if self.lead_histories.present?
      self.lead_histories.last.next_approach_day
    end
  end

  def full_address
    address = ""
    if self.prefecture != nil
      address.concat(self.prefecture)    
    end
    if self.city != nil
      address.concat(self.city)
    end
    if self.street != nil
      address.concat(self.street)
    end
    if self.building != nil
      address.concat(" ").concat(self.building)
    end
    return address

  end
end
