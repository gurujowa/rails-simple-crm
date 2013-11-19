class TeacherOrder < ActiveRecord::Base

  has_paper_trail 
  has_many :teacher_order_courses
  has_many :courses, through: :teacher_order_courses
  belongs_to :teacher
  validates :unit_price, presence: true, numericality: {only_integer: true, greater_than: 1000}
  validates :teacher_id, presence: true
  validates :description, presence: true
  validates :courses, presence: true

  validate :check_company_name
  validate :check_teacher_include

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

  def check_teacher_include
    self.courses.each do |c|
       te_id = []
       c.periods.each do |p|
         if p.teacher_id == self.teacher_id
            te_id.push self.teacher_id
         end
       end

       if te_id.size == 0
         errors.add(:courses, c.name + 'には' + self.teacher.name + "のコマがありません" )
       end
    end
  end

  def total_period
    ind = 0
    course_where.each do |p|
      ind += 1
    end

    return ind
  end

  def total_time
    time = 0
    course_where.each do |p|
      time += p.total_time
    end
    return time
  end

  def total_price
    total_hour = self.total_time / 60
    price = total_hour * unit_price
    return (price + self.additional_price).to_i
  end

  def start_date
     periods = course_where
     if periods.present? 
       return periods.first.day
     else
       return nil
     end
  end

  def end_date
     periods = course_where
     if periods.present? 
       return periods.first.day
     else
       return nil
     end
  end

  def company_name
    self.courses.first.company.client_name
  end

  def course_where
    Period.where(:course_id => self.course_ids).where(:teacher_id => self.teacher_id).order(:day)
  end

end
