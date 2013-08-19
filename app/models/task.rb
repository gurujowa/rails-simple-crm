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
 
end
