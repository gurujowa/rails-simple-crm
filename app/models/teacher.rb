class Teacher < ActiveRecord::Base
  validates :email, :format=>{:with=>/[a-z0-9_.-]+@([a-z0-9-]+\.)+[a-z]{2,4}/i, :message=>":メールアドレスの形式がおかしいです", :allow_blank=>true}
  validates :tel, :format=>{:with=>/[0-9-]/, :message=>"：電話番号は半角数値と「-」だけ", :allow_blank=>true}
  
  def self.work_possible_hash
    {:possible => 0, :subtle => 1, :impossible => 2}
  end

  
  def name
    return last_kanji + " " + first_kanji
  end
end
