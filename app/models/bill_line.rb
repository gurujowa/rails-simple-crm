class BillLine < ActiveRecord::Base

  has_paper_trail 
  belongs_to :bill


  def tax_exclude_price
    unit_price.to_i * quantity.to_i
  end

  def tax_price
    if tax_rate.present? and tax_exclude_price.present?
      return tax_exclude_price * tax_rate / 100
    else
      return 0
    end
  end

  def tax_include_price
    tax_exclude_price + tax_price
  end

  def total_price
    tax_include_price
  end
end
