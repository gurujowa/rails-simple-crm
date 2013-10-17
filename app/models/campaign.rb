class Campaign < ActiveRecord::Base
  validates :bill, presence: true  
  validates :sent, presence: true  

  has_many :companies

  def reaction
     return self.companies.length
  end

  def conversion
     if self.companies.length != 0 and self.sent != 0
       return self.companies.length.to_f / self.sent * 100
     end 
  end

  def cpa
      if self.companies.length != 0
        return self.bill / self.companies.length 
      else
        return 0
      end
  end

end
