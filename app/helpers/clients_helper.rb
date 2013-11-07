module ClientsHelper
  def options_gender(default= nil)
    options_for_select([["男",1],["女",2]], default)
  end
end
