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
  extend Enumerize

  has_paper_trail 
  has_many :estimate_lines, :dependent => :destroy
  accepts_nested_attributes_for :estimate_lines, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? }
  enumerize :client_type, in: [:company, :lead]

  validates :client_id, presence: true
  validates :client_type, presence: true

  def client_name
    if client_type == "company"
      return Company.find(self.client_id).client_name
    else client_type == "lead"
      return Lead.find(self.client_id).name
    end
    raise "invalid client type"
  end

  def company_id
    if self.client_type == "company"
      return client_id
    end
  end

  def lead_id
    if self.client_type == "lead"
      return client_id
    end
  end

  def total_price
     price = 0
     self.estimate_lines.each do |c|
       price += c.total_price
     end
     return price
  end

end
