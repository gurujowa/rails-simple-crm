class ChangeEstimateAndBillingName < ActiveRecord::Migration[5.0]
  def change
    @estimates = Estimate.all()
    @estimates.each do |e|
      if e.display_name.blank? and e.lead.present?
        e.display_name = e.lead.name
        e.save!
      end
    end

    @bill = BillingPlan.all()
    @bill.each do |b|
      if b.display_name.blank? and b.lead.present?
        b.display_name = b.lead.name
        b.save!
      end
    end
  end
end
