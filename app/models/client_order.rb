# == Schema Information
#
# Table name: client_orders
#
#  id           :integer          not null, primary key
#  company_id   :integer          not null
#  price        :integer          not null
#  invoice_flg  :boolean          default(FALSE), not null
#  payment_flg  :boolean          default(FALSE), not null
#  invoice_date :date
#  payment_date :date
#  memo         :text
#  created_at   :datetime
#  updated_at   :datetime
#

class ClientOrder < ActiveRecord::Base

  belongs_to :company


end
