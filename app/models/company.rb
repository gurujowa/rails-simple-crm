# == Schema Information
#
# Table name: companies
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  category         :string(255)
#  client_name      :string(255)
#  tel              :string(255)
#  fax              :string(255)
#  mail             :string(255)
#  status_id        :integer          not null
#  client_person    :string(255)
#  zipcode          :string(255)
#  prefecture       :string(255)
#  city             :string(255)
#  address          :string(255)
#  building         :string(255)
#  created_by       :string(255)
#  updated_by       :string(255)
#  sales_person     :integer          not null
#  approach_day     :date
#  chance           :integer
#  industry_id      :integer          default(1), not null
#  appoint_plan     :date
#  campaign_id      :integer          not null
#  latitude         :float
#  longitude        :float
#  active_st        :string(255)      default("notstart"), not null
#  regular_staff    :integer
#  nonregular_staff :integer
#  memo             :text
#

class Company < ActiveRecord::Base
extend Enumerize

  acts_as_taggable 
  has_paper_trail 

  has_many :contacts, :dependent => :destroy
  has_many :logs, :dependent => :destroy
  has_many :clients, :dependent => :destroy
  has_many :courses, :dependent => :destroy
  has_many :billing_plans

  accepts_nested_attributes_for :contacts,  :allow_destroy => true , reject_if: proc { |attributes| attributes['memo'].blank? and attributes['con_type'].blank? }
  accepts_nested_attributes_for :clients,  :allow_destroy => true , reject_if: :all_blank

  belongs_to :campaign
  belongs_to :industry
  belongs_to :created_user , class_name: "User", foreign_key: "created_by"
  belongs_to :updated_user , class_name: "User", foreign_key: "updated_by"

  validates :mail, :email_format => {:message => ' メールアドレスの形式が不適切です'}, :allow_blank => true
  validates :campaign_id, presence: true  
  validates :industry_id, presence: true
  validates :active_st, presence: true  
  validates :tel, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true},  :uniqueness => true, :presence => true
  validates :fax, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :zipcode, presence: true, length: {maximum: 8, :message => '郵便番号は７文字以内です'}, format: {with: /\d{3}\-\d{4}/, message: "半角数字とハイフンのみで入力してください。（ハイフンが必要です）", allow_blank: true }
  validates :prefecture, presence: true, length: {maximum: 4, :message => '都道府県は４文字以内で入力してください'}
  validates :city, presence: true, length: {maximum: 8, :message => '市町村区は、検索しやすいよう市のみをいれてください。（例：横浜市）'}
  validates :address, presence:true

  enumerize :active_st, in: [:draft, :contract , :impossible, :pending]

  scope :has_contract, lambda{ where("active_st = ?", :contract)}
  scope :is_active, lambda { where(:active_st => @@active_in ) }

  @@active_in = ["draft","contract"]

  def is_active
    if @@active_in.include?(self.active_st)
      return true
    else
      return false
    end
  end

  def end_date
    array = []
    if self.courses.blank?
      return nil
    end

    self.courses.each do |p|
      array.push(p.end_date) if p.end_date.present?
    end
    sorted = array.sort { |a, b| b <=> a }
    sorted[0]
  end

  def client_person
    if self.clients.present?
      return self.clients.first.name
    end
  end

  def name
      return client_name
  end



  def full_address(building=true)
    address = ""
    if self.prefecture != nil
      address.concat(self.prefecture)    
    end
    if self.city != nil
      address.concat(self.city)
    end
    if self.address != nil
      address.concat(self.address)
    end
    if self.building != nil and building == true
      address.concat(" ").concat(self.building)
    end
    return address

  end

  def full_address2
    address = ""
    if self.prefecture2 != nil
      address.concat(self.prefecture2)    
    end
    if self.city2 != nil
      address.concat(self.city2)
    end
    if self.address2 != nil
      address.concat(self.address2)
    end
    if self.building2 != nil
      address.concat(" ").concat(self.building2)
    end
    return address

  end


  def estimates
    estimates = Estimate.where(client_id: self.id).where(client_type: "company")
    return estimates
  end


  def updated_name
    if self.updated_user.present?
      return self.updated_user.name
    else
      return "未設定"
    end
  end

end
