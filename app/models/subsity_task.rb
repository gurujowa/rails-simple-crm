class SubsityTask < ActiveRecord::Base
extend Enumerize


  validates :name, presence: true
  validates :depend, presence: true
  validates :month, presence: true
  validates :day, presence: true
  belongs_to :subsity
  enumerize :depend, in: [:start,:end]
end
