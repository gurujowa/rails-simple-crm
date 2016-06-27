class LeadTask < ActiveRecord::Base
  belongs_to :lead
  belongs_to :lead_subsity

  validates :due_date, presence: true
  validates :name, presence: true  

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names + ["会社名", "助成金概要","利用助成金"]
      all.each do |l|
        values = l.attributes.values_at(*column_names)
        values << l.lead.name
        values << l.lead_subsity&.name
        values << l.lead_subsity&.subsity&.name
        csv << values
      end
    end
  end
end
