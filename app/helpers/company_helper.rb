module CompanyHelper
  def options_chance(default= nil)
    options_for_select([10,20,30,40,50,60,70,80,90], default)
  end
end
