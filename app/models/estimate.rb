# == Schema Information
#
# Table name: estimates
#
#  id         :integer          not null, primary key
#  company_id :integer          not null
#  expired    :date
#  send_flg   :boolean          default(FALSE), not null
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#

class Estimate < ActiveRecord::Base

  has_paper_trail 
  belongs_to :company
  has_many :estimate_lines, :dependent => :destroy
  accepts_nested_attributes_for :estimate_lines, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? }

  validates :company_id, presence: true

  def total_price
     price = 0
     self.estimate_lines.each do |c|
       price += c.total_price
     end
     return price
  end

end
