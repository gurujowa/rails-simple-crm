class AttendMailer < ApplicationMailer
  after_action :check_attend_mail_flg , only: [:today_mail,:tomorrow_mail, :holiday_mail]

  def today_mail(period, go)
    @period = period
    @teacher = period.teacher

    address = get_address_options(go, @teacher.email)
    address.merge!(subject: "【ユアブライトからの大事なお知らせ】ご登壇確認（#{period.course.lead.corp_name} - #{period.day})")
    mail(address)
  end


  def tomorrow_mail(period, go)
    @period = period
    @teacher = period.teacher

    address = get_address_options(go, @teacher.email)
    address.merge!(subject: "【ユアブライトからの大事なお知らせ】翌日のご登壇確認（#{period.course.lead.corp_name} - #{period.day})")
    mail(address)
  end

  def holiday_mail(period, go)
    @period = period
    @teacher = period.teacher

    address = get_address_options(go, @teacher.email)
    address.merge!(subject: "【ユアブライトからの大事なお知らせ】休日中のご登壇確認（#{period.course.lead.corp_name} - #{period.day})")
    mail(address)
  end

  def alert_mail(periods)
    @not_attend_periods = periods.where(attend_date: nil)
    if @not_attend_periods.present?
      mail(to: Rails.application.config.default_mailaddress, subject: "出席アラート")
    end
  end

  private
  def check_attend_mail_flg
    if @teacher.attend_mail_flg == false
      mail.perform_deliveries = false
    end
  end

  def get_address_options(go, teacher_email)
    if go == "go"
      if Rails.env == "production"
        address = {to: teacher_email, cc: Rails.application.config.default_mailaddress}
      else
        raise "send teacher's mail can only production env"
      end
    else
      address = {to: Rails.application.config.default_mailaddress}
    end
    return address
  end


end
