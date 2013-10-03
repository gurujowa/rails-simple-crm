class Course < ActiveRecord::Base
  belongs_to :company
  has_many :teacher_order_courses
  has_many :teacher_order, through: :teacher_order_courses
  has_many :periods, :dependent => :destroy
  accepts_nested_attributes_for :periods, :allow_destroy => true

  validates :name, presence: true
  validates :company_id, presence: true

  @@color = ["MidnightBlue", "DarkViolet", "Crimson", "Navy", "Black", "Green", "DarkRed", "Gray", "Sienna", "DarkMagenta"]

  def color
    key = self.id % 10
    return @@color[key]
  end

  def text_color
    return "white"
  end

  def getTotalTime
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
     return %Q{#{self.company.client_name} - #{self.name}(#{self.getStartDate}/#{self.getEndDate})}
  end

end
