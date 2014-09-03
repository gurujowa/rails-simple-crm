class Nego < ActiveRecord::Base

  has_paper_trail 
  belongs_to :company
  belongs_to :user

  scope :is_active, lambda {joins(:status,:company).where("companies.active_st in ('contract','active_a','active_b','active_c')").where.not("statuses.rank = ?","A")}
  scope :is_contract,lambda {where(status_id: 19)} 

  validates :user_id, presence: true  


  after_save do
    Log.create!(:company_id => self.company.id, :status_id => self.status_id,  :created_by => self.user_id)
  end

end
