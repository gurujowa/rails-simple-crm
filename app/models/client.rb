# == Schema Information
#
# Table name: clients
#
#  id                :integer          not null, primary key
#  last_name         :string(255)      not null
#  first_name        :string(255)
#  last_kana         :string(255)
#  first_kana        :string(255)
#  tel               :string(255)
#  fax               :string(255)
#  mail              :string(255)
#  gender            :integer          not null
#  official_position :string(255)
#  company_id        :integer          not null
#  memo              :text
#  created_at        :datetime
#  updated_at        :datetime
#

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
