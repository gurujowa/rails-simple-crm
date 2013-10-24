class CompanyAlert

  attr_reader :errors

  def initialize
    @errors = []
  end

  def check(company)
    course_null_check company

  end

  def self.check_all
      companies = Company.where(status_id: 19)
      alert = self.new
      companies.each do |c|
        alert.check c
      end
      alert
  end


  private
  def course_null_check(c)
    if c.courses.length == 0
      push_error c, "契約済みなのにコースがありません"
    end
  end

  def push_error c, message, day = nil
    message = CompanyAlertMessage.new c, message
    @errors.push message
  end

end

class CompanyAlertMessage
  attr_accessor :company,  :message

  def initialize company, message
    @company = company
    @message = message
  end


  def client_name
    @company.client_name
  end

  def mail_message
    message = %Q{#{@message} 会社名：#{client_name}}
    message
  end

  def to_s
    mail_message
  end
end
