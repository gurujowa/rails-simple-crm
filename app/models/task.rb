class Task < ActiveRecord::Base
  belongs_to :company
  belongs_to(:task_type, :foreign_key => "type_id", :class_name =>"TaskType")

end
