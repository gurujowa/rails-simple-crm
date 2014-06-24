class LeadHistory < ActiveRecord::Base
  extend Enumerize
  belongs_to :lead
  belongs_to :user

  enumerize :status, in: [:ing_tel, :ing_mail, :ing_leave, :ing_next,:ing_re, :ing_defer,
    :done_appoint, :done_send, :done_ng_up, :done_ng_down, :done_block, :done_claim,
    :forbidden_gone, :forbidden_ng]

end
