class LeadComment < ActiveRecord::Base
  extend Enumerize
  
  has_paper_trail 
  belongs_to :lead
  belongs_to :user
  validates :memo, presence: true  
  enumerize :category, in: [:joseikin, :jimu]

  def color
    if self.category == :joseikin
      return "success"
    elsif self.category == :jimu
      return "default"
    else
      raise "no self.category"
    end
  end

end
