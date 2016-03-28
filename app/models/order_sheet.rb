class OrderSheet < ActiveRecord::Base
extend Enumerize

  has_paper_trail 

  has_many :order_sheet_lines, :dependent => :destroy
  accepts_nested_attributes_for :order_sheet_lines, :allow_destroy => true, reject_if: proc { |attributes| attributes['price'].blank? }

  enumerize :status, in: [:draft, :active , :cancel]


  def total_price
    price = 0
    self.order_sheet_lines.each do |l|
      price += l.price
    end
    return price
  end


  def self.to_csv
    CSV.generate do |csv|
      csv << column_names + ["total_price"]

      all.each do |l|

        values = l.attributes.values_at(*column_names)

        if l.order_sheet_lines.present?
          osl = l.order_sheet_lines
          values = values + [osl.sum(:price)]
        else
          values = values + [0]
        end
        csv << values
      end
    end
  end

end
