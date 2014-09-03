module ClientsHelper
  def options_gender(default= nil)
    options_for_select([["男",1],["女",2]], default)
  end

  def gender_text(index)
    if index == 1
      return "男性"
    elsif index == 2
      return "女性"
    elsif index == 3
      return "不明"
    end
  end
end
