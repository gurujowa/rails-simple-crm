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
  scope  :sent_list, lambda{ tagged_with("資料郵送済").order("approach_day DESC")}

  @@sent_tag = "資料郵送済"


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
    return self.tag_list.index(@@sent_tag).present?
  end

  def send_pamph
    if self.is_sent
      self.tag_list.remove(@@sent_tag)
      self.save
    else
      self.tag_list.add(@@sent_tag)
      self.save
    end
  end

  def zip_created_at
    tagging = self.tag_all_list.find {|t| t[:name] == @@sent_tag}
    return tagging[:created_at]
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
