# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  company_id         :integer          not null
#  order_flg          :boolean          default(FALSE), not null
#  book_flg           :boolean          default(FALSE), not null
#  resume_flg         :boolean          default(FALSE), not null
#  end_report_flg     :boolean          default(FALSE), not null
#  created_at         :datetime
#  updated_at         :datetime
#  end_form_flg       :boolean          default(FALSE), not null
#  diploma_flg        :boolean          default(FALSE), not null
#  reception_seal_flg :boolean          default(FALSE), not null
#  cert_seal_flg      :boolean          default(FALSE), not null
#

class Course < ActiveRecord::Base
extend Enumerize

  has_paper_trail 
  belongs_to :company
  belongs_to :user
  has_many :teacher_order_courses
  has_many :teacher_order, through: :teacher_order_courses
  has_many :periods, :dependent => :destroy
  accepts_nested_attributes_for :periods, :allow_destroy => true

  validates :name, presence: true
  validates :address, presence: true
  validates :station, presence: true
  validates :responsible, presence: true
  validates :tel, presence: true
  validates :company_id, presence: true

  enumerize :status, in: [:draft, :active , :cancel]
  @@color = ["MidnightBlue", "DarkViolet", "Crimson", "Navy", "Black", "Green", "DarkRed", "Gray", "Sienna", "DarkMagenta"]

  def color
    key = self.id % 10
    return @@color[key]
  end

  def wrike_flg course_flg
    flg = self.read_attribute(course_flg)
    if flg == true
      return "Completed"
    elsif flg == false
      return "Active"
    else
      raise course_flg + " is not flag"
    end
  end

  def text_color
    return "white"
  end

  def total_time
    getTotalTime
  end

  def getTotalTime
    periods = self.periods
    total = 0

    periods.each do |p|
      total += p.getTotal
    end

    total
  end

  def start_date
    getStartDate
  end

  def end_date
    getEndDate
  end

  def observe_text
    if self.observe_flg == true
      return "必要"
    else
      return "不必要"
    end
  end


  def getStartDate
    periods = self.periods
    array = []

    periods.each do |p|
      array.push(p.day)
    end
    array.sort[0]
  end

  def getEndDate
    periods = self.periods
    array = []

    periods.each do |p|
      array.push(p.day)
    end
    sorted = array.sort { |a, b| b <=> a }
    sorted[0]
  end

  def to_select_label
     return %Q{#{self.company.client_name} - #{self.name}(#{self.getStartDate}/#{self.getEndDate})}
  end

end
