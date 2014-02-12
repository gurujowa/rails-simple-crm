# == Schema Information
#
# Table name: teachers
#
#  id              :integer          not null, primary key
#  first_kanji     :string(255)      not null
#  last_kanji      :string(255)      not null
#  first_kana      :string(255)      not null
#  last_kana       :string(255)      not null
#  work_possible   :integer          default(0), not null
#  genre           :string(255)
#  memo            :text
#  created_at      :datetime
#  updated_at      :datetime
#  orientation_flg :boolean
#  profile_flg     :boolean
#  photo_flg       :boolean
#  regist_flg      :boolean
#  contract_flg    :boolean
#  bill            :integer
#  tel             :string(255)
#  email           :string(255)
#

class Teacher < ActiveRecord::Base

  has_paper_trail 
  validates :email, :format=>{:with=>/[a-z0-9_.-]+@([a-z0-9-]+\.)+[a-z]{2,4}/i, :message=>":メールアドレスの形式がおかしいです", :allow_blank=>true}
  validates :tel, :format=>{:with=>/[0-9-]/, :message=>"：電話番号は半角数値と「-」だけ", :allow_blank=>true}
  
  def self.work_possible_hash
    {:possible => 0, :subtle => 1, :impossible => 2}
  end

  
  def name
    return last_kanji + " " + first_kanji
  end
end
