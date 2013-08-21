class TaskProgress
  attr_reader :list
  @@id_list = {finish: 4, waiting: 3, canceled: 5, planning: 1, active: 2}
  
  def initialize
    @list = {finish: "完了", waiting: "確認待", canceled: "Cancel", planning: "開始前", active: "進行中"}
    @id_list = {finish: 4, waiting: 3, canceled: 5, planning: 1, active: 2}
  end
  
  def getSymbol(id)
    return @id_list.key(id)
  end

  def self.getId(symbol)
    return @@id_list[symbol]
  end

  
  def getNameById(id)
    symbol = @id_list.key(id)
    return @list[symbol]
  end
  
  def getIdValList()
   keyAry = @list.values
   keyValue = @id_list.values
   ary = [keyAry,keyValue].transpose
   h = Hash[*ary.flatten]
   return h
  end
  
end