class Task < ActiveRecord::Base
  belongs_to :company
  belongs_to(:task_type, :foreign_key => "type_id", :class_name =>"TaskType")

  validates :type_id, presence: true  ,:numericality => true
  validates :duedate, presence: true
  validates :name, presence: true
  validates :assignee, presence: true,:numericality => true
  validates :created_by, presence: true,:numericality => true
  validates :progress_id, presence: true,:numericality => true
  validates :company_id, presence: true,:numericality => true
 
  def getProgress
    progress = TaskProgress.new
    name = progress.getNameById(self.progress_id)
  end

  def company_name
    c = self.company
    if c.present?
      return c.client_name
    else
      return "エラー：会社がありません"
    end
  end
  
  def getProgressList
    progress = TaskProgress.new
    return  progress.getIdValList()
  end
  
  def getBootstrapColor
    progress = TaskProgress.new
    if (progress.getSymbol(self.progress_id) == :finish) 
      return "muted"
    elsif (self.duedate < Date.today)
      return "error"
    elsif (progress.getSymbol(self.progress_id) == :planning)
      return "info"
    elsif (progress.getSymbol(self.progress_id) == :canceled)
      return "warning"
    else
      return "success"
    end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << ["ステータス","会社名","名前","期限","進捗","メモ"]
      all.each do |row|
        csv << [row.company.status.name,row.company.client_name,row.name,row.duedate,row.getProgress(),row.note]
      end
    end
  end
  
end
