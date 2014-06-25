class CompanyTelValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    c = Company.find_by tel: value
    if c.present?
      record.errors[attribute] << (options[:message] || "の電話番号は会社情報に存在します")
    end
  end
end
