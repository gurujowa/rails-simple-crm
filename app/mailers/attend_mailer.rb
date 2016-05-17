class AttendMailer < ApplicationMailer

  def teacher_mail(period, go)
    @period = period
    @teacher = period.teacher
    
    #参加可否の確認
    return nil if @teacher.attend_mail_flg == false

    if go == "go"
      if Rails.env == "production"
        address = {to: @teacher.email, cc: Rails.application.config.default_mailaddress}
      else
        raise "send teacher's mail can only production env"
      end
    else
      address = {to: Rails.application.config.default_mailaddress}
    end
    address.merge!(subject: "【ユアブライトからの大事なお知らせ】ご登壇確認（#{period.course.lead.corp_name} - #{period.day})")
    mail(address)
  end

  def alert_mail()
    @not_attend_periods = Period.today.where(attend_date: nil)
    if @not_attend_periods.present?
      mail(to: Rails.application.config.default_mailaddress, subject: "出席アラート")
    end
  end

end
