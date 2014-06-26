class Lead < ActiveRecord::Base
  extend Enumerize
  belongs_to :user
  has_many :lead_histories

  enumerize :campaign, in: [:fax,:homepage,:tel,:introduce,:other]

  validates :tel, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true},  :uniqueness => true, :presence => true
  validates :fax, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :zipcode,  length: {maximum: 8, :message => '郵便番号は７文字以内です'}, format: {with: /\d{3}\-\d{4}/, message: "半角数字とハイフンのみで入力してください。（ハイフンが必要です）", allow_blank: true }
  validates :prefecture,  length: {maximum: 4, :message => '都道府県は４文字以内で入力してください'}
  validates :city,  length: {maximum: 8, :message => '市町村区は、検索しやすいよう市のみをいれてください。（例：横浜市）'}

  scope :attack_list, lambda {
    where("leads.user_id is null")
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
