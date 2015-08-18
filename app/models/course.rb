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
  belongs_to :lead
  belongs_to :user
  has_many :teacher_order_courses
  has_many :teacher_orders
  has_many :periods, :dependent => :destroy
  accepts_nested_attributes_for :periods, :allow_destroy => true

  has_many :tasks, :dependent => :destroy
  accepts_nested_attributes_for :tasks, :allow_destroy => true

  validates :name, presence: true
  validates :address, presence: true
  validates :station, presence: true
  validates :responsible, presence: true
  validates :tel, presence: true
  validates :lead_id, presence: true

  enumerize :status, in: [:draft, :active , :cancel]
  @@color = ["MidnightBlue", "DarkViolet", "Crimson", "Navy", "Black", "Green", "DarkRed", "Gray", "Sienna", "DarkMagenta"]


  def color
    key = self.id % 10
    return @@color[key]
  end

  def text_color
    return "white"
  end

  def total_time
    return total_time_cal
  end

  def total_time_cal
    periods = self.periods
    total = 0

    periods.each do |p|
      total += p.getTotal
    end

    total
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
    return %Q{#{self.lead.name} - #{self.name}(#{self.start_date}/#{self.end_date})}
  end

  alias_method :start_date, :getStartDate
  alias_method :end_date, :getEndDate
end
