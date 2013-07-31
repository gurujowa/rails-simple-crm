class GraphsController < ApplicationController
  def index
    @day_created = make_day_created
    @week_created = make_week_created
  end

  def created

  end
  
  private
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
