class OrderSheetLine < ActiveRecord::Base

  has_paper_trail 
  belongs_to :order_sheet
  validates :price, presence: true

  def self.to_csv
    c = CSV.generate do |csv|
      csv << column_names + ["title","company", "send_to"]

      all.each do |l|
        values = l.attributes.values_at(*column_names)
        values << l.order_sheet.title
        values << l.order_sheet.company_info
        values << l.order_sheet.send_to
        csv << values
      end
    end
    c.tosjis
  end

end
