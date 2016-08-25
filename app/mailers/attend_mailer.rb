class AttendMailer < ApplicationMailer
  after_action :check_attend_mail_flg , only: [:today_mail,:tomorrow_mail, :holiday_mail, :monthly_mail]
  after_action :unnecessary_click_mail , only: [:today_mail,:tomorrow_mail, :holiday_mail]

  def monthly_mail(teacher_id, periods, go)
    @teacher = Teacher.find(teacher_id)
    @periods = periods.sort_by {|p| p.day }
    @target_month = Time.current.next_month.strftime("%-m")
    address = get_address_options(go, @teacher.email)
    address.merge!(subject: "#{@target_month}月分研修日程確認依頼")
    mail(address)

  end

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
    @not_attend_periods = periods.joins(:teacher).where("periods.attend_date is null").where("teachers.attend_mail_flg = ?", true)
    if @not_attend_periods.present?
      mail(to: Rails.application.config.default_mailaddress, subject: "出席アラート")
    end
  end

  private
  def check_attend_mail_flg
    if @teacher.attend_mail_flg == false
      mail.perform_deliveries = false
    end

    if @teacher.email.blank?
      mail.perform_deliveries = false
    end
  end

  def unnecessary_click_mail 
    if @teacher.send_alert_flg == false
      @period.update_attributes!(attend_date: Time.current)
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
