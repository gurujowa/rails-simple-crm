require "moji"

class Lead < ActiveRecord::Base
  extend Enumerize
  acts_as_taggable 
  belongs_to :user
  has_many :lead_histories, dependent: :destroy
  has_many :estimates, dependent: :destroy

  has_one :lead_interview, dependent: :destroy
  accepts_nested_attributes_for :lead_interview

  enumerize :campaign, in: [:fax,:homepage,:tel,:introduce,:other]
  enumerize :sex, in: [:male,:female]

  validates :tel, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true},  :uniqueness => true, :presence => true
  validates :fax, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :zipcode,  length: {maximum: 8, :message => '郵便番号は７文字以内です'}, format: {with: /\d{3}\-\d{4}/, message: "半角数字とハイフンのみで入力してください。（ハイフンが必要です）", allow_blank: true }
  validates :prefecture,  length: {maximum: 4, :message => '都道府県は４文字以内で入力してください'}
  validates :city,  length: {maximum: 8, :message => '市町村区は、検索しやすいよう市のみをいれてください。（例：横浜市）'}

  scope :between_last_approach , lambda {|gt, lt| 
    sc = current_scope || relation
    sc = sc.where("lead_histories.approach_day > ?", DateTime.parse(gt)) if gt.present?
    sc = sc.where("lead_histories.approach_day < ?", DateTime.parse(lt)) if lt.present?
    sc
  }

  scope :between_next_approach , lambda {|gt, lt| 
    sc = current_scope || relation
    sc = sc.where("lead_histories.next_approach_day > ?", DateTime.parse(gt)) if gt.present?
    sc = sc.where("lead_histories.next_approach_day < ?", DateTime.parse(lt)) if lt.present?
    sc
  }

  ransacker :max_approach_day do |parent|
    Arel.sql('max(lead_histories.approach_day)')
  end

  def last_sent_date
    sent_date = []
    self.lead_histories.each do |lh|
      if lh.is_sent
        sent_date.push lh.shipped_at
      end
    end

    sent_date.sort!
    return sent_date.last
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

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names + ["タグ", "対応日時", "対応ステータス", "対応メモ"] +  LeadInterview.column_names

      all.each do |l|

        values = l.attributes.values_at(*column_names)

        if l.tag_list.present?
            values << l.tag_list.to_s
        else
            values << ""
        end

        if l.lead_histories.present?
          lh = l.lead_histories.last
          values = values + [lh.approach_day, lh.lead_history_status.name , lh.memo]
        else
          values = values + ["","",""]
        end

        if l.lead_interview.present?
          interview_values = l.lead_interview.attributes.values_at(*LeadInterview.column_names)
          values = values + interview_values
        end
        csv << values
      end
    end
  end


  def last_approach
    if self.lead_histories.present?
      self.lead_histories.last
    end
  end

  def full_address(build=true)
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
    if self.building != nil and build == true
      address.concat(" ").concat(self.building)
    end
    return address
  end

end
