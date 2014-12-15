class ChangeFlagRequirementFromTeacherOrderLines < ActiveRecord::Migration
  def change

    lines = TeacherOrderLine.all
    lines.each do |l|
      if l.invoice_flg == nil
        l.update_attribute(:invoice_flg, false)
      end
      if l.payment_flg == nil
        l.update_attribute(:payment_flg, false)
      end
    end
    change_column :teacher_order_lines, :invoice_flg, :boolean, null: false, default: false
    change_column :teacher_order_lines, :payment_flg, :boolean, null: false, default: false
  end
end
