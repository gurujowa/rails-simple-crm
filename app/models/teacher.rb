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

  has_many :periods, order: "day"
  belongs_to :director, :class_name => "Teacher", :foreign_key => "director_id"

  has_paper_trail 
  validates :email, :format=>{:with=>/[a-z0-9_.-]+@([a-z0-9-]+\.)+[a-z]{2,4}/i, :message=>":メールアドレスの形式がおかしいです", :allow_blank=>true}
  validates :tel, :format=>{:with=>/[0-9-]/, :message=>"：電話番号は半角数値と「-」だけ", :allow_blank=>true}

  default_scope -> {order(:last_kana)}
  scope :is_active, lambda { where(work_possible: 0)}
  
  def self.work_possible_hash
    {:possible => 0, :subtle => 1, :impossible => 2}
  end

  def director_name
    if self.director.present?
      return self.director.name
    end
  end

  def short_name
    kanji_name = last_kanji + " " + first_kanji
  end

  def to_order_name
    if self.director_name.present?
      self.director_name
    else
      short_name
    end

  end
  
  def name
    kanji_name = last_kanji + " " + first_kanji
    if self.director.present?
      return kanji_name + "(" + self.director.last_kanji + "D)"
    else
      kanji_name
    end
  end

  def id_and_name
    return self.name + " (" + self.id.to_s
  end

  def kana
    return last_kana + " " + first_kana
  end
end
