# == Schema Information
#
# Table name: billing_plans
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  company_id   :integer          not null
#  tax_rate     :integer          default(0), not null
#  status       :string(255)      default("draft"), not null
#  created_at   :datetime
#  updated_at   :datetime
#  publish_date :date
#

class BillingPlan < ActiveRecord::Base
  extend Enumerize

  has_paper_trail 
  belongs_to :company
  has_many :billing_plan_lines, :dependent => :destroy , :order => "bill_date ASC"
  accepts_nested_attributes_for :billing_plan_lines, reject_if: :all_blank
  enumerize :status, in: [:draft, :completed, :canceled], default: :draft
  
  validates :name, presence: true  
  validates :company_id, presence: true, numericality: true
  validates :tax_rate, presence: true, numericality: true
  validates :status, presence: true, inclusion: enumerized_attributes[:status].values

  def bill_start
    if self.billing_plan_lines.present?
      return self.billing_plan_lines.first.bill_date
    end
  end

  def bill_end
    if self.billing_plan_lines.present?
      return self.billing_plan_lines.last.bill_date
    end
  end

  def total_price
     price = 0
     self.billing_plan_lines.each do |c|
       price += c.price
     end
     return price
  end

  def tax_price
     return total_price * (tax_rate.to_f * 0.01)
  end

  def tax_include_price
     return total_price + tax_price
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << BillingPlanLine.column_names
      all.each do |row|
        row.billing_plan_lines.each do |l|
          csv << l.attributes.map{|a| a[1]}.concat([l.billing_plan.company.name])
        end
      end
    end
  end

end
