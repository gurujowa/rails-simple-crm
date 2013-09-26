class TeacherOrder < ActiveRecord::Base
  has_many :courses
  belongs_to :teacher
  validates :unit_price, presence: true, numericality: {only_integer: true, greater_than: 1000}
  validates :teacher_id, presence: true
  validates :courses, presence: true
  validate :check_company_name

  def check_company_name
    courses = self.courses
    ar = []
    courses.each do |c|
       ar.push(c.company_id)
    end
    if (ar.uniq.size >= 2)
      errors.add(:courses, 'すべて同じ会社のコースをいれる必要があります')
    end
  end

  def total_period
    ind = 0
    self.courses.each do |c|
      c.periods.each do |p|
        ind += 1
      end
    end

    return ind
  end

  def total_time
    total_time = 0
    self.courses.each do |c|
      total_time += c.getTotalTime
    end
    return total_time
  end

  def total_price
    total_hour = self.total_time / 60
    price = total_hour * unit_price
    return (price + self.additional_price).to_i
  end

  def start_date
    Period.where(:course_id => self.course_ids).order(:day).first.day
  end

  def end_date
    Period.where(:course_id => self.course_ids).order(:day).last.day
  end

  def company_name
    self.courses.first.company.client_name
  end
end
