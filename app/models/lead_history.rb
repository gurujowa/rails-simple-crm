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

  @@sent_tag = "資料郵送済"


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

end
