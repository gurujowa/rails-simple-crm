class LeadEstimate < ActiveRecord::Base

  has_paper_trail 
  belongs_to :lead
  has_many :lead_estimate_lines, :dependent => :destroy
  accepts_nested_attributes_for :lead_estimate_lines, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? }

  validates :lead_id, presence: true

  def total_price
     price = 0
     self.lead_estimate_lines.each do |c|
       price += c.total_price
     end
     return price
  end

end
