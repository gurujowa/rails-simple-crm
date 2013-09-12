class Company < ActiveRecord::Base
  has_many :contact, :dependent => :destroy
  has_many :task, :dependent => :destroy  
  has_many :course, :dependent => :destroy
  belongs_to :status
  belongs_to :industry
  accepts_nested_attributes_for :contact,  :allow_destroy => true , reject_if: proc { |attributes| attributes['memo'].blank? and attributes['con_type'].blank? }

  validates :status_id, presence: true  
  validates :chance, presence: true  
  validates :lead, presence: true
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
  
  
  def getContact
    con_str = "<ul>"
    contact.each do |d|
      if d.memo != nil
        con_str << "<li>"
        con_str.concat(d.memo)
        con_str << "</li>"
      end
    end
    con_str << "</ul>"
    return con_str
  end
end
