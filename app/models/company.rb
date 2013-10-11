class Company < ActiveRecord::Base
  has_many :contacts, :dependent => :destroy
  has_many :task, :dependent => :destroy  
  has_many :course, :dependent => :destroy
  has_many :estimate
  belongs_to :status
  belongs_to :campaign
  belongs_to :industry
  accepts_nested_attributes_for :contacts,  :allow_destroy => true , reject_if: proc { |attributes| attributes['memo'].blank? and attributes['con_type'].blank? }

  validates :status_id, presence: true  
  validates :campaign_id, presence: true  
  validates :chance, presence: true  
  validates :industry_id, presence: true
  validates :sales_person, presence: true
  validates :tel, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :fax, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :mail,  :email_format => {:message => ' メールアドレスの形式が不適切です', :allow_blank=>true} 
  validates :client_name, presence: true, length: {maximum: 50}
  validates :prefecture, presence: true, length: {maximum: 4, :message => '都道府県は４文字以内で入力してください'}
  validates :city, presence: true, length: {maximum: 8, :message => '市町村区は、検索しやすいよう市のみをいれてください。（例：横浜市）'}
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
      csv << ["ランク","見込み度", "会社名","初回アポ日","提案見積日","契約日","入金日","ステータス","コンタクト"]
      key = 1
      all.each do |row|
        csv << [key, row.chance, row.client_name, row.appoint_plan, row.proposed_plan, row.contract_plan, row.payment_plan, row.status.name,row.getContactMemo.join(",")]
        key += 1
      end
    end
  end

end
