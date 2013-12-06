class ContactType
  @@list = {tel: [1,"荷電"], appoint: [2,"アポあり訪問"], visit: [6, "アポなし訪問"], other: [3, "その他"]}
  @@map = nil


  def self.all
    unless @@map.present?
      @@map = @@list.map{|id, val| self.new(val[0],val[1])}
    end
    @@map
  end

  def self.id_search id
    found = nil
    self.all.each do |c|
      if c.id == id
        found = c
      end
    end
    found
  end

  def symbol
    found = nil
    self.all.each do |c|
      if c.id == id
        found = c
      end
    end
    found
  end

  def self.id symbol
    type = @@list[symbol]
    return nil if type.blank?
    return type[0]
  end

  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def to_s
    @name
  end
  
end
