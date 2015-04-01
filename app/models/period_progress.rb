class PeriodProgress
    attr_reader :id,:attr,:old_value,:new_value


  def initialize(q)
    @attr = q[1]
    @old_value = q[2]
    @new_value = q[3]
    @id = q[4]
  end

  def update
    period = Period.find(@id)
    send("update_"+ @attr, period)
  end

  private
  def update_observer(period)
    old_user_id = @old_value.present? ? User.find_by(name: @old_value).id : nil
    new_user_id = User.find_by(name: @new_value).id
    if new_user_id.blank?
      return false
    end

    _check(period, :user_id, old_user_id) if old_user_id.present?
    period.update!(user_id: new_user_id)
    return true
  end

  def update_day(period)
    _check(period, :day, Date.parse(@old_value))
    period.update!(day: Date.parse(@new_value))
  end

  def update_teacher(period)
    old_user_id = _get_teacher_id(@old_value)
    new_user_id = _get_teacher_id(@new_value)

    _check(period, :teacher_id, old_user_id)
    period.update!(teacher_id: new_user_id)
    return true
  end

  def _get_teacher_id(str)
    m = str.match(/^.+\((\d+)/)
    return m[1].to_i
  end


  def _check(period, attribute, value)
    if value.present? && period.read_attribute(attribute) != value
      raise %(period value and handsontable attr is different. value = #{value} & period = #{period.read_attribute(attribute)})
    end
  end

end
