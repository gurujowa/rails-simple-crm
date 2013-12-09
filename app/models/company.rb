class Company < ActiveRecord::Base
extend Enumerize


  has_paper_trail 
  geocoded_by :getAddress
  after_validation :geocode

  has_many :contacts, :dependent => :destroy
  has_many :logs, :dependent => :destroy
  has_many :clients, :dependent => :destroy
  has_many :tasks, :dependent => :destroy  
  has_many :courses, :dependent => :destroy
  has_many :estimate
  has_many :company_proposed_plans, :dependent => :destroy
  has_many :company_contract_plans, :dependent => :destroy
  has_many :company_payment_plans, :dependent => :destroy  

  accepts_nested_attributes_for :company_proposed_plans , reject_if: proc { |a| a['duedate'].blank? }
  accepts_nested_attributes_for :company_contract_plans , reject_if: proc { |a| a['duedate'].blank? }
  accepts_nested_attributes_for :company_payment_plans , reject_if: proc { |a| a['duedate'].blank? }
  accepts_nested_attributes_for :contacts,  :allow_destroy => true , reject_if: proc { |attributes| attributes['memo'].blank? and attributes['con_type'].blank? }
  accepts_nested_attributes_for :clients,  :allow_destroy => true , reject_if: :all_blank

  belongs_to :status
  belongs_to :campaign
  belongs_to :industry
  belongs_to :created_user , class_name: "User", foreign_key: "created_by"
  belongs_to :sales_user , class_name: "User", foreign_key: "sales_person"
  belongs_to :updated_user , class_name: "User", foreign_key: "updated_by"

  validates :status_id, presence: true  
  validates :active_st, inclusion:{ in: ["active","impossible","pending"],  message: "接触前はランクPのみ有効です"} , :unless => Proc.new{|company| "P" == company.status.rank } 
  validates :campaign_id, presence: true  
  validates :chance, presence: true  
  validates :industry_id, presence: true
  validates :sales_person, presence: true
  validates :tel, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true},  :uniqueness => true, :presence => true
  validates :fax, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :zipcode, presence: true, length: {maximum: 8, :message => '郵便番号は７文字以内です'}, format: {with: /\d{3}\-\d{4}/, message: "半角数字とハイフンのみで入力してください。（ハイフンが必要です）", allow_blank: true }
  validates :prefecture, presence: true, length: {maximum: 4, :message => '都道府県は４文字以内で入力してください'}
  validates :city, presence: true, length: {maximum: 8, :message => '市町村区は、検索しやすいよう市のみをいれてください。（例：横浜市）'}
  validates :address, presence:true

  enumerize :active_st, in: [:notstart, :active, :pending, :impossible], :default => :notstart

  scope :is_active, lambda {|c| where("active_st = ?" , "active")}

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
      return client_person
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

  def sales_name
    if self.sales_person.present?
      User.find(self.sales_person).name
    else
      return ""
    end
  end

  def max_rank
    array = []
    self.logs.each do |c|
      if c.status.present?
        array.push(c.status.rank)
      end
    end
    return array.sort!.first
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

  def proposed_plan
    if self.company_proposed_plans.present?
      self.company_proposed_plans.last.duedate
    end
  end

  def contract_plan
    if self.company_contract_plans.present?
      self.company_contract_plans.last.duedate
    end
  end

  def payment_plan
    if self.company_payment_plans.present?
      self.company_payment_plans.last.duedate
    end
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

  def self.to_csv
    CSV.generate do |csv|
      csv << self.column_names.concat(["担当者名","ランク","ステータス名","営業マン", "コンタクト","キャンペーン","最終到達ランク","アポイント数"])
      key = 1
      all.each do |row|
        memos = row.contacts.map{|c| c.memo}
        csv << row.attributes.map{|a| a[1]}.concat([row.name, row.status.rank, row.status.name, row.sales_name, memos.join("\n・"), row.campaign.name, row.max_rank, row.got_appoint])
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

  
  after_save do
    Log.create!(:company_id => self.id, :status_id => self.status_id, :created_by => self.updated_name)
  end

end
