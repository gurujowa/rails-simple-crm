namespace :convert do
  task "teacher_order" => :environment do
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
      ors.save!
      t.teacher_order_lines.each do |tl|
        ors.order_sheet_lines.create!(price: tl.price, invoice_date: tl.payment_date, invoice_flg: tl.invoice_flg, payment_flg: tl.payment_flg, memo: tl.memo)
      end

    end
  end

end
