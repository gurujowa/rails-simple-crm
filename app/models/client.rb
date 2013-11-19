class Client < ActiveRecord::Base

  has_paper_trail 
  belongs_to :company

  validates :last_name, presence: true, length: {maximum: 10}
  validates :gender, presence: true
  validates :tel, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :fax, :format=>{:with=>/\A[0-9-]*\z/, :message=>"：半角数値と「-」だけ有効です", :allow_blank=>true}
  validates :mail,  :email_format => {:message => ' メールアドレスの形式が不適切です', :allow_blank=>true} 
  
  def name
    name = self.last_name
    if self.first_name.present?
      return name + " " + self.first_name
    else
      return name
    end
  end
end
