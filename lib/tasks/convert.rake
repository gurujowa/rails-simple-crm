namespace :convert do
  task "teacher_order" => :environment do
    OrderSheet.destroy_all(memo: "業務依頼書よりコンバート")
    to = TeacherOrder.all

    to.each do |t|
      ors = OrderSheet.new
      ors.title = t.description
      ors.send_to = t.teacher.name
      ors.order_date = t.order_date
      ors.status = t.status
      ors.mention = t.mention
      ors.memo = "業務依頼書よりコンバート"
      ors.company_info = t.course.lead.name
      ors.course_info = t.course.name
      ors.course_info << "\n[実施日]\n"
      t.course.periods.each do |p|
        ors.course_info << p.day.to_s(:date) + "\n"
      end
      ors.save!
      t.teacher_order_lines.each do |tl|
        ors.order_sheet_lines.create!(price: tl.price, invoice_date: tl.payment_date, invoice_flg: tl.invoice_flg, payment_flg: tl.payment_flg, memo: tl.memo)
      end

    end
  end

end
