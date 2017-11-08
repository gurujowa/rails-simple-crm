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
  has_many :estimate_lines, :dependent => :destroy
  has_many :estimate_subsities, :dependent => :destroy
  accepts_nested_attributes_for :estimate_lines, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :estimate_subsities, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? }

  belongs_to :lead

  def client_name
    if display_name.present?
      return self.display_name
    else
      return "no name"
    end
  end


  def total_subsities_price
     price = 0
     self.estimate_subsities.each do |c|
       price += c.price
     end
     return price
  end

  def own_pay
    return total_price - total_subsities_price
  end

  def total_price
     price = 0
     self.estimate_lines.each do |c|
       price += c.total_price
     end
     return price
  end

end
