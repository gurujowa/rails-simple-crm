class LeadSubsity < ActiveRecord::Base
  belongs_to :lead
  belongs_to :subsity

  def tasks
    tasks = []
    self.subsity.subsity_tasks.each do |t|
      task = LeadSubsityTask.new(t,self)
      tasks << task
    end

    tasks
  end
end

class LeadSubsityTask
  def initialize(subsity_task, lead_subsity)
    @subsity_task = subsity_task
    @lead_subsity = lead_subsity
  end

  def name
    @subsity_task.name
  end

  def lead
    @lead_subsity.lead
  end

  def lead_id
    @lead_subsity.lead_id
  end

  def subsity
    @subsity_task.subsity
  end

  def due_date
    if @subsity_task.depend == "start"
      date = @lead_subsity.start
    elsif @subsity_task.depend == "end"
      date = @lead_subsity.end
    else
      raise "no depend"
    end
    date.months_since(@subsity_task.month).days_since(@subsity_task.day)


  end

end
