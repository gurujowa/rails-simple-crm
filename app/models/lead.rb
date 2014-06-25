class Lead < ActiveRecord::Base
  belongs_to :user
  has_many :lead_histories

  default_scope :order => 'created_at DESC'


  ransacker :full_text do |p|
    Arel::Nodes::InfixOperation.new('||', p.table[:name] , p.table[:prefecture])
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

  def last_approach_status
    if self.lead_histories.present?
      self.lead_histories.last.lead_history_status
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
