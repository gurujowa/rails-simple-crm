class GraphsController < ApplicationController
  def index
    hash = Company.connection.select_all(
    'select strftime("%Y-%m-%d", created_at) m_cre, count(id) as count
     from companies
     where m_cre != "2013-07-28"
     group by m_cre
     order by m_cre desc
     limit 8')

    column = []
    data = []

    hash.each do |h|
      column.push Date.parse(h["m_cre"]).strftime('%m/%d')
      data.push h["count"]
    end

    @h = LazyHighCharts::HighChart.new("graph") do |f|
      f.ｙAxis[
      {title: {text: '登録数'}},
      ]
      f.chart(:type => "column")
      f.title(:text => "日ごと登録数")
      f.xAxis(:categories => column)
      f.series(:name => "登録数",
               :data => data)
    end
  end

  def created

    hash = Company.connection.select_all(
    'select strftime("%Y-%m-%d", created_at) m_cre, count(id) as count
     from companies
     where m_cre != "2013-07-28"
     group by m_cre
     order by m_cre desc')

    column = []
    data = []

    hash.each do |h|
      column.push Date.parse(h["m_cre"]).strftime('%m/%d(%a)')
      data.push h["count"]
    end

    @h = LazyHighCharts::HighChart.new("graph") do |f|

      f.chart(:type => "column")
      f.title(:text => "日ごと登録数")
      f.xAxis(:categories => column)
      f.series(:name => "登録数",
               :data => data)
    end

  end
end
