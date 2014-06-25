class Lead < ActiveRecord::Base
  belongs_to :user
  has_many :lead_histories

  scope :attack_list, lambda {
    where("user_id is null")
  }

  ransacker :max_approach_day do |parent|
    ar = Arel.sql('max(lead_histories.approach_day)')
  end

  def today?
    if self.last_approach_day.present?
      if self.last_approach_day.to_date == Date.current
        return true
      end
    end

    return false
  end

  def next_approach_day
    if self.lead_histories.present?
      self.lead_histories.last.next_approach_day
    end
  end

  def last_approach_day
    if self.lead_histories.present?
      self.lead_histories.last.approach_day
    end
  end

  def mylist? (current_user_id)
    if self.user_id == current_user_id
      return true
    else
      return false
    end
  end

  def other_user? (current_user_id)
    if self.user_id.blank?
      return false
    end

    if self.user_id != current_user_id
      return true
    else
      return false
    end
  end

  def last_approach
    if self.lead_histories.present?
      self.lead_histories.last
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
