class Campaign < ActiveRecord::Base
  validates :bill, presence: true  
  validates :sent, presence: true  

  has_many :companies

end
