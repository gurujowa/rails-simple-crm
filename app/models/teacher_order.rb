# == Schema Information
#
# Table name: teacher_orders
#
#  id               :integer          not null, primary key
#  teacher_id       :integer
#  unit_price       :integer
#  memo             :text
#  order_date       :date
#  payment_date     :date
#  created_at       :datetime
#  updated_at       :datetime
#  additional_price :integer          default(0), not null
#  students         :integer
#  description      :string(255)
#  invoice_date     :date
#

class TeacherOrder < ActiveRecord::Base
extend Enumerize

  has_paper_trail 
  belongs_to :teacher
  belongs_to :course

  has_many :teacher_order_lines, :dependent => :destroy
  has_many :teacher_order_periods, :dependent => :destroy
  accepts_nested_attributes_for :teacher_order_lines, :allow_destroy => true, reject_if: proc { |attributes| attributes['price'].blank? }
  accepts_nested_attributes_for :teacher_order_periods, :allow_destroy => true, reject_if: proc { |attributes| attributes['day'].blank? }

  validates :teacher_id, presence: true
  validates :description, presence: true
  validates :course, presence: true

  enumerize :status, in: [:draft, :active , :cancel]
  enumerize :period_type, in: [:auto, :manual , :none]

  def lead
    self.course.lead
  end

  def total_period
    ind = 0
    course_where.each do |p|
      ind += 1
    end

    return ind
  end

  def total_time
    if self.period_type == "auto"
      total_time_auto
    elsif self.period_type == "manual"
      total_time_manual
    else
      ""
    end
  end

  def total_time_auto
    time = 0
    course_where.each do |p|
      time += p.total_time
    end
    return time
  end

  def total_time_manual
    periods = self.teacher_order_periods
    total = 0

    periods.each do |p|
      total += p.total_time
    end

    total
  end
  

  def total_price
    price = 0
    self.teacher_order_lines.each do |l|
      price += l.price
    end
    return price
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
       return periods.last.day
     else
       return nil
     end
  end

  def course_address
    self.course.address
  end

  def course_students
    self.course.students
  end

  def course_station
    self.course.station
  end

  def course_responsible
    self.course.responsible
  end

  def course_tel
    self.course.tel
  end

  def lead_name
    return self.course.lead.name
  end

  def course_where
    Period.where(:course_id => self.course_ids).where(:teacher_id => self.teacher_id).order(:day)
  end

end
