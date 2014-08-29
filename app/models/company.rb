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


  has_paper_trail 
  geocoded_by :getAddress

  after_validation :geocode

  has_many :contacts, :dependent => :destroy
  has_many :logs, :dependent => :destroy
  has_many :clients, :dependent => :destroy
  has_many :negos, :dependent => :destroy
  has_many :tasks, :dependent => :destroy  
  has_many :courses, :dependent => :destroy
  has_many :billing_plans

  accepts_nested_attributes_for :contacts,  :allow_destroy => true , reject_if: proc { |attributes| attributes['memo'].blank? and attributes['con_type'].blank? }
  accepts_nested_attributes_for :clients,  :allow_destroy => true , reject_if: :all_blank
  accepts_nested_attributes_for :negos,  :allow_destroy => true , 
    reject_if: proc{|a| a['name'].blank?}

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

  enumerize :active_st, in: [:contract , :active_a, :active_b, :active_c, :pending, :notfull,  :impossible]

  scope :sales_where, lambda {|a| joins(:negos).where("negos.user_id = ?", a)}
  scope :has_contract, lambda{ where("active_st = ?", :contract)}
  scope :is_active, lambda { where(:active_st => @@active_in ) }

  @@active_in = ["active_a", "active_b", "active_c", "contract"]

  def is_active
    if @@active_in.include?(self.active_st)
      return true
    else
      return false
    end
  end

  def salesman
    if self.negos.length >= 2
      user_names = self.negos.map {|x| x.user.name}
      return user_names.uniq.join("：")
    else
      self.negos.first.user.name
    end
  end

  def getAddress
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
    return address
  end

  def client_person
    if self.clients.present?
      return self.clients.first.name
    end
  end

  def name
      return client_name
  end

  def got_appoint
    if self.contacts.blank?
      return nil
    end

    count = 0
    self.contacts.each do |c|
      if c.con_type == ContactType.id(:appoint)
        count += 1
      end
    end
    count
  end



  def full_address
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
    if self.building != nil
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

  def getContactMemo
    array = []
    self.contacts.each do |c|
      if c.memo != nil
        array.push(c.memo)
      end
    end
    return array
  end

  def contact_memo
     getContactMemo
  end

  def appoint_contact
    unless self.contacts
      return nil
    end

    found = nil
    self.contacts.each do |c|
      if c.con_type == ContactType.id(:first_appoint)
        found = c
      end
    end
    found
  end

  def proposed_contact
    unless self.contacts
      return nil
    end

    found = nil
    self.contacts.each do |c|
      if c.con_type == ContactType.id(:proposal)
        found = c
      end
    end
    found
  end

  def status_name
    if self.negos.length >= 2
      status_names = self.negos.map {|x| x.status.name}
      return status_names.uniq.join("：")
    else
      status =  self.negos.first.status
      if status.present?
        status.name
      end
    end
  end

  def estimates
    estimates = Estimate.where(client_id: self.id).where(client_type: "company")
    return estimates
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << self.column_names.concat(["担当者名", "コンタクト","キャンペーン","アポイント数","営業マン"])
      key = 1
      all.each do |row|
        memos = row.contacts.map{|c| c.memo}
        csv << row.attributes.map{|a| a[1]}.concat([row.client_person,  memos.join("\n・"), row.campaign.name, row.got_appoint, row.salesman])
        key += 1
      end
    end
  end

  def updated_name
    if self.updated_user.present?
      return self.updated_user.name
    else
      return "未設定"
    end
  end

end
