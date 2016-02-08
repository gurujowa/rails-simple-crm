class SubsityTask < ActiveRecord::Base
extend Enumerize


  validates :name, presence: true
  validates :depend, presence: true
  validates :month, presence: true
  validates :day, presence: true
  belongs_to :subsity
  enumerize :depend, in: [:start,:end]

  def result_date(date_start,date_end)
    if self.depend == "start"
      date = date_start
    elsif self.depend == "end"
      date = date_end
    else
      raise "no depend"
    end
    date.months_since(self.month).days_since(self.day)
  end


end
