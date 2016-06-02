class CourseAddress < ActiveRecord::Base
  belongs_to :course

  def projector_text
    case projector
    when true
      text = "あり"
    when false
      text = "なし"
    when nil
      text = "未定"
    else
      raise "projector failed. value is #{projector}"
    end

    text += "#{projector_detail}" if projector_detail.present?
    text
  end


  def board_text
    case board
    when true
      text = "あり"
    when false
      text = "なし"
    when nil
      text = "未定"
    else
      raise "board failed. value is #{board}"
    end

    text += "(#{board_detail})" if board_detail.present?
    text
  end

end
