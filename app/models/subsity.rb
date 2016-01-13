class Subsity < ActiveRecord::Base
  has_many :subsity_tasks , :dependent => :destroy
  accepts_nested_attributes_for :subsity_tasks, :allow_destroy => true

end
