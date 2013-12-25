class BillMailer < ActionMailer::Base
  default from: "antenna@yourbright.co.jp"

  def sales()
    @line = BillingPlanLine.sales

    if Rails.env == 'production'
      to = ["yamashita.hayato@yourbright.co.jp","miwa@yourbright.co.jp"]
    else
      to = "yamashita.hayato@yourbright.co.jp"
    end

    mail(:to => to, :subject => "今月の請求表")
  end
end
