function utc2dateString(utc_msec) {
  d=new Date();
  d.setTime(utc_msec);
  return d.getFullYear()+'/'+(d.getMonth()+1)+'/'+d.getDate();
}

function highstock_created(url) {
  $.getJSON(url, function(json, status) {

    // Highchart全体設定
    Highcharts.setOptions({
      global: {  // グローバルオプション
        useUTC: false   // GMTではなくJSTを使う
      },
      lang: {  // 言語設定
        rangeSelectorZoom: '表示範囲',
        resetZoom: '表示期間をリセット',
        resetZoomTitle: '表示期間をリセット',
        rangeSelectorFrom: '表示期間',
        rangeSelectorTo: '～',
        printButtonTitle: 'チャートを印刷',
        exportButtonTitle: '画像としてダウンロード',
        downloadJPEG: 'JPEG画像でダウンロード',
        downloadPDF: 'PDF文書でダウンロード',
        downloadPNG: 'PNG画像でダウンロード',
        downloadSVG: 'SVG形式でダウンロード',
        months: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        weekdays: ['日', '月', '火', '水', '木', '金', '土'],
        numericSymbols: null   // 1000を1kと表示しない
      }
    });
    
    // 株価チャートを生成
    window.chart = new Highcharts.StockChart({
      chart: {
        renderTo : 'chart_container'  // チャートを描画する要素のID
      },
      
      credits: {  // 右下のクレジット
        enabled: false
      },
      
      title: {  // チャートタイトル
        text : '株価チャート'
      },

      legend: {  // 凡例
                enabled: true,
                align: '',
                verticalAlign: 'top',
        floating: true,
        x: 0
            },

      series: [{  // 系
        name : '株価',
        data : json['price'],
        type: 'spline',
        color: '#4572a7',    // 色の指定
        shadow : true,
        tooltip : {
          valueDecimals : 0
        }
      },{
        name : '13週移動平均',
        data : json['week13avg'],
        type: 'spline',
        color: '#aa4444',    // 色の指定
        shadow : true
      }],
          
      xAxis: [{  // X軸
        labels: {
          formatter: function(){ return utc2dateString(this.value); }
        }
      }],
      
      plotOptions: {  // プロットオプション
                series: {
          dataGrouping: {
            dateTimeLabelFormats: {
               millisecond: ['%Y/%m/%d %H:%M:%S.%L', '%Y/%m/%d %H:%M:%S.%L', '-%H:%M:%S.%L'],
               second: ['%Y/%m/%d %H:%M:%S', '%Y/%m/%d %H:%M:%S', '-%H:%M:%S'],
               minute: ['%Y/%m/%d %H:%M', '%Y/%m/%d %H:%M', '-%H:%M'],
               hour: ['%Y/%m/%d %H:%M', '%Y/%m/%d %H:%M', '-%H:%M'],
               day: ['%Y/%m/%d', '%Y/%m/%d', '-%Y/%m/%d'],
               week: ['%Y/%m/%d', '%Y/%m/%d', '-%Y/%m/%d'],
               month: ['%B %Y', '%B', '-%B %Y'],
               year: ['%Y', '%Y', '-%Y']
            }
          }
        }
            },
            
      tooltip: {  // ツールチップ
        headerFormat: '<b>{point.key}</b><br/>',
        pointFormat: '<span style="color:{series.color}">{series.name}</span>: {point.y}<br/>',
        xDateFormat: '%Y/%m/%d'
      },

      navigator: {  // ナビゲータ
        baseSeries: 0
      },
      
      rangeSelector: { // 表示幅選択ボタン
        selected : 1,
        inputDateFormat: '%Y/%m/%d',
        inputEditDateFormat: '%Y/%m/%d',
        buttons : [{
          type : 'day', // 分単位 (0)
          count : 90,     // 約 240 分のデータを表示
          text : '3ヶ月'       // ボタンの表示名
        }, {
          type : 'day', // 分単位 (0)
          count : 180,     // 約 240 分のデータを表示
          text : '6ヶ月'       // ボタンの表示名
        }, {
          type : 'year',    // 日単位 (1)
          count : 1,      // 約 90 日のデータを表示
          text : '1年'
        }, {
          type : 'year',    // 日単位 (1)
          count : 2,      // 約 90 日のデータを表示
          text : '2年'
        }, {
          type : 'year',    // 日単位 (1)
          count : 3,      // 約 90 日のデータを表示
          text : '3年'
        }, {
          type : 'all',    // 全データ (2)
          count : 1,
          text : 'All'
        }]
      }
    });
  });
}
