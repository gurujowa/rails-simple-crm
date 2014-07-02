class PivotTable

  @data

  def select_list
    User.where(id: [13,2,1])
  end

  def init_user_id_hash
    users = select_list
    user_id_hash = Hash[]
    users.each do |u|
      user_id_hash.store u.id, 0
    end
    user_id_hash
  end

  def user_header
    users = select_list
    user_list = []
    users.each do |u|
      user_list.push u.name
    end
    user_list

  end

  def store_user_list value,user_id, hash = nil
    if hash.blank?
      hash = init_user_id_hash
    end
    hash[user_id] = value
    hash
  end

  def set_rows calculation
      table = Hash[]
      users = init_user_id_hash
      calculation.each do |c|
        day = c[0][1]
        user_id = c[0][0]
        value = c[1]
        if table.has_key? day
          table[day] = store_user_list(value,user_id, table[day])
        else
          table.store(day, store_user_list(value,user_id))
        end
      end
      @data = table.sort
  end

  def each
    @data.each do |person|
      yield person
    end
  end

  def to_a
    @data
  end
end
