class Nego < ActiveRecord::Base

  has_paper_trail 
  belongs_to :company
  belongs_to :user
  belongs_to :status


  scope :is_active, lambda {joins(:status,:company).where("companies.active_st in ('active_a','active_b','active_c')").where.not("statuses.rank = ?","A")}
  scope :is_contract,lambda {where(status_id: 19)} 

end
