class LeadSubsity < ActiveRecord::Base
  belongs_to :lead
  belongs_to :subsity

  validates :name, presence: true
  validates :subsity_id, presence: true
  validates :start, presence: true
  validates :end, presence: true


  def task_list
    tasks = []
    tl = self.subsity.subsity_tasks
    tl.each do |subsity_task|
      lead_task = LeadTask.new
      lead_task.name = subsity_task.name
      lead_task.due_date = subsity_task.result_date(self.start,self.end)
      lead_task.lead_subsity_id = self.id
      lead_task.lead_id = self.lead_id
      tasks.push lead_task
    end

    tasks
  end
end
