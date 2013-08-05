class GraphsController < ApplicationController
  def index
    @day_created = make_day_created
    @week_created = make_week_created
    @rank_stacking = make_rank_stacking
    @closing = make_closing
    
  end

  def created

  end
  
  private
  def make_closing
     hash = Company.connection.select_all(
    '
    SELECT logs.company_id, strftime("%Y-%m", Min(logs.created_at)) m_cre 
    FROM logs 
    INNER JOIN statuses ON logs.status_id = statuses.id  
    GROUP BY logs.company_id, statuses.rank 
    HAVING (((statuses.rank)="A")) AND  m_cre > "2013-06-03";
    ')

    data = Hash.new
    hash.each do |h|
        append_hash(data, h["m_cre"])
    end
    data = sort_by_key(data)
    
    graph = LazyHighCharts::HighChart.new("graph") do |f|
      f.ｙAxis[
      {title: {text: '契約数'}},
      ]
      f.chart(:type => "column")
      f.title(:text => "契約数")
      f.xAxis(:categories => data.keys)
      f.series(:name => "契約数",
               :data => data.values)
    end
    
    return graph
  end
  
    def make_day_created
     hash = Company.connection.select_all(
    'select strftime("%Y-%m-%d", created_at) m_cre, count(id) as count
     from companies
     where m_cre > "2013-07-28"
     group by m_cre
     order by m_cre desc
     limit 8')

    column = []
    data = []

    hash.each do |h|
      column.push Date.parse(h["m_cre"]).strftime('%m/%d')
      data.push h["count"]
    end

    graph = LazyHighCharts::HighChart.new("graph") do |f|
      f.ｙAxis[
      {title: {text: '登録数'}},
      ]
      f.chart(:type => "column")
      f.title(:text => "日ごと登録数")
      f.xAxis(:categories => column)
      f.series(:name => "登録数",
               :data => data)
    end
    
    return graph
  end
  
  private
  def make_rank_stacking
     hash = Company.connection.select_all(
    "SELECT companies.id as c_id,  Max(statuses.rank) AS rank_max,   strftime('%Y-%m', companies.created_at) as m_cre, 
     Min(statuses.rank) AS rank_min 
     FROM companies 
     INNER JOIN logs ON logs.company_id = companies.id 
     INNER JOIN statuses ON statuses.id = logs.status_id 
     WHERE companies.lead = 'FAX' 
     GROUP BY companies.id;

")

    data = Hash.new
    column = Hash.new

    hash.each do |h|
      if(data.has_key?(h["rank_min"]))
        append_hash(data[h["rank_min"]], h["m_cre"])
        append_hash(column, h["m_cre"])
      else
        data[h["rank_min"]] = Hash.new
        data[h["rank_min"]][h["m_cre"]] = 1
      end
    end
    data = sort_by_key(data)

    graph = LazyHighCharts::HighChart.new("graph") do |f|
      f.ｙAxis(
      :title => {:text => '登録数'}, 
      :stackLabels => {:enabled => true} 
      )
      f.chart(:type => "column")
      f.title(:text => "ランク積み上げ(FAX)")
      f.xAxis(:categories => sort_by_key(column).keys)
      data.each do |d|
        f.series(:name => d[0], :data => sort_by_key(d[1]).values, :stack => "male")
      end
      f.plot_options(:column => {
        :stacking => "normal"
      })
    end
    
    return graph
  end
  
  private
  def append_hash(data, key)
      if (data.has_key?(key)) 
        data[key] += 1
      else
        data[key] = 1
      end     

  end
  
  private
  def sort_by_key(data)
    data = data.sort_by{|key, value| key}
    hash = Hash.new
    data.each do |d|
      hash[d[0]] = d[1]
    end
    return hash
  end
  
  private
  def make_week_created
     hash = Company.connection.select_all(
    'select strftime("%Y-%W", created_at) w_cre, count(id) as count
     from companies
     where strftime("%Y-%m-%d", created_at) > "2013-07-28"
     group by w_cre
     order by w_cre desc
     limit 8')

    column = []
    data = []

    hash.each do |h|
      column.push h["w_cre"]
      data.push h["count"]
    end

    graph = LazyHighCharts::HighChart.new("graph") do |f|
      f.ｙAxis[
      {title: {text: '登録数'}},
      ]
      f.chart(:type => "column")
      f.title(:text => "週ごと登録数")
      f.xAxis(:categories => column)
      f.series(:name => "登録数",
               :data => data)
    end
    
    return graph
  end
end
