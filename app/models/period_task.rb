class PeriodTask < ActiveRecord::Base
  belongs_to :period
  enum task_type: { teacher_announce: 0, receive_resume: 1, check_resume: 2 , unnecessary: 3, sent: 4}

end
