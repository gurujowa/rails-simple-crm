class Company < ActiveRecord::Base
  has_many :contacts, :dependent => :destroy
  has_many :clients, :dependent => :destroy
  has_many :tasks, :dependent => :destroy  
  has_many :courses, :dependent => :destroy
  has_many :estimate

  belongs_to :status
  belongs_to :campaign
  belongs_to :industry
  accepts_nested_attributes_for :contacts,  :allow_destroy => true , reject_if: proc { |attributes| attributes['memo'].blank? and attributes['con_type'].blank? }
  accepts_nested_attributes_for :clients,  :allow_destroy => true , reject_if: :all_blank

  validates :status_id, presence: true  
  validates :campaign_id, presence: true  
  validates :chance, presence: true  
  validates :industry_id, presence: true
  validates :sales_person, presence: true
  validates :tel, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :fax, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :zipcode, presence: true, length: {maximum: 8, :message => '郵便番号は７文字以内です'}, format: {with: /\d{3}\-\d{4}/, message: "半角数字とハイフンのみで入力してください。（ハイフンが必要です）", allow_blank: true }
  validates :prefecture, presence: true, length: {maximum: 4, :message => '都道府県は４文字以内で入力してください'}
  validates :city, presence: true, length: {maximum: 8, :message => '市町村区は、検索しやすいよう市のみをいれてください。（例：横浜市）'}
  validates :address, presence:true
  validates :bill,  :numericality => true, :allow_nil => true

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

  def sales_name
    if self.sales_person.present?
      User.find(self.sales_person).name
    else
      return ""
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
    if self.address != nil
      address.concat(self.address)
    end
    if self.building != nil
      address.concat(" ").concat(self.building)
    end
    return address

  end
  
  def getCreatedBy()
    if self.created_by.present?
      User.find(self.created_by).name
    else
      return ""
    end
  end
  
   def getUpdatedBy()
    if self.updated_by.present?
      User.find(self.updated_by).name
    else
      return ""
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
      csv << self.column_names.concat(["ランク","ステータス名","営業マン", "コンタクト","キャンペーン"])
      key = 1
      all.each do |row|
        memos = row.contacts.map{|c| c.memo}
        csv << row.attributes.map{|a| a[1]}.concat([row.status.rank, row.status.name, row.sales_name, memos.join("\n・"), row.campaign.name])
        key += 1
      end
    end
  end

  

end
