# == Schema Information
#
# Table name: public_estimates
#
#  id         :integer          not null, primary key
#  company_id :integer          not null
#  expired    :date
#  send_flg   :boolean          default(FALSE), not null
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#

class PublicEstimate < ActiveRecord::Base
  extend Enumerize

  has_paper_trail 
  has_many :public_estimate_lines, :dependent => :destroy
  accepts_nested_attributes_for :public_estimate_lines, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? }
  enumerize :client_type, in: [:company, :lead]

  validates :client_id, presence: true
  validates :client_type, presence: true

  def client_name
    if display_name.present?
      return self.display_name
    elsif client_type == "company"
      return Company.find(self.client_id).client_name
    elsif client_type == "lead"
      return Lead.find(self.client_id).name
    else
      raise "invalid client type"
    end
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
     self.public_estimate_lines.each do |c|
       price += c.total_price
     end
     return price
  end

end
