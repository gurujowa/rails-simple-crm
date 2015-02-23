class LeadHistory < ActiveRecord::Base
  
  has_paper_trail 
  acts_as_taggable 

  belongs_to :lead
  belongs_to :lead_history_status
  belongs_to :user

  validates :approach_day, presence: true  
  validates :user_id, presence: true  
  validates :lead_history_status_id, presence: true  

  scope  :exclude_initial, lambda{ where('created_at > ?', DateTime.new(2014,06,27))}
  scope  :status_zip, lambda{ where('lead_history_status_id = ?', 8).order("approach_day DESC")}
  scope  :sent_list, lambda{ where('lead_histories.shipped_at is not null').order("approach_day DESC")}

  has_many :lead_history_attachments
  accepts_nested_attributes_for :lead_history_attachments


  def is_last
    if self == self.lead.lead_histories.last
      return true
    else
      return false
    end
  end

  def status_name
    return self.lead_history_status.name
  end

  def is_sent
    return self.shipped_at.present?
  end

  def send_pamph
    if self.is_sent
      self.shipped_at = nil
      self.save
    else
      self.shipped_at = DateTime.now
      self.save
    end
  end

  def tag_all_list
    tag_list = []
    tags = tags_on(:tags)
    tags.each do |tag|
      tagging = tag.taggings.find_by(taggable_id: self.id)
      tag_list.push({name: tag.name, created_at: tagging.created_at})
    end
    tag_list

  end

end
