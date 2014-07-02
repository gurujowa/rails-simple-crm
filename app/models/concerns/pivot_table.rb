class PivotTable

  @data
  @group2_list
  @row_data

  def initialize(list, group_key)
    hash = Hash[]
    list.each do |u|
      hash.store u.read_attribute(group_key), Hash[]
    end
    @group2_list = hash
  end


  def day_header
    day_list = []
    @row_data.each do |c|
      day = c[0][1]
      day_list.push day
    end
    day_list.uniq
  end

  def set_rows calculation
    @row_data = calculation
      table = @group2_list
      calculation.each do |c|
        day = c[0][1]
        group2 = c[0][0]
        value = c[1]
        if table.has_key? group2
          table[group2] = store_day(value,day, table[group2])
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

  private
  def store_day value, day, hash
    unless hash.has_key? day
      hash = init_day_hash @row_data
    end
    hash.store(day, value)
    hash
  end


  def init_day_hash calculation
      day_hash = Hash[]
      uniq_list = day_header
      uniq_list.each do |l|
        day_hash.store l, 0
      end
      day_hash
  end

end
