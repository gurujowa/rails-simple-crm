class Report
  
  def initialize name
    path = Rails.root.join('config').join('spreadsheet').join(name).to_s
    @book = Spreadsheet.open path
    @sheet = @book.worksheet(0)
    @name = name
  end


  def cell cell, value
    c = convert_cell(cell)
    @sheet[c[1],c[0]] = value
  end

  def write
    path = Rails.root.join('tmp').join(@name).to_s
    @book.write path
    return path
  end


  def convert_cell(cell)
    raise ArgumentError unless cell.class == String
    raise ArgumentError unless /^([a-z]+)([0-9]*)$/i =~cell
    col = row = 0
    cols = $1.upcase.bytes.to_a.map {|x| x-65}.reverse
    0.upto(cols.length-1) do |l|
      l==0 ? col = cols[l]  : col += (cols[l]+1)*(26**l)
    end
    row = $2.to_i
    row = row - 1 if row && row > 0
    return [col,row]
  end



end
