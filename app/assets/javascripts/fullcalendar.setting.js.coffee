$.fn.fullcalendar = 
    # ヘッダーのタイトルとボタン
    header:
      # title, prev, next, prevYear, nextYear, today
      left: "prev,next today"
      center: "title"
      right: "month agendaWeek agendaDay"
    # jQuery UI theme
    theme: true
    # 最初の曜日
    firstDay: 1
    # 土曜、日曜を表示
    weekends: true
    # 週モード (fixed, liquid, variable)
    weekMode: "fixed"
    # 週数を表示
    weekNumbers: false
    # 高さ(px)
    #height: 700,
    # コンテンツの高さ(px)
    #contentHeight: 600,
    # カレンダーの縦横比(比率が大きくなると高さが縮む)
    #aspectRatio: 1.35,
    # 初期表示ビュー
    defaultView: "month"    
    # 列の書式
    columnFormat:
      month: "ddd" # 月
      week: "d'('ddd')'" # 7(月)
      day: "d'('ddd')'" # 7(月)
    # タイトルの書式
    titleFormat:
      month: "yyyy年M月" # 2013年9月
      week: "yyyy年M月d日{ ～ }{[yyyy年]}{[M月]d日}" # 2013年9月7日 ～ 13日
      day: "yyyy年M月d日'('ddd')'" # 2013年9月7日(火)
    # ボタン文字列
    buttonText:
      prev: "&lsaquo;" # <
      next: "&rsaquo;" # >
      prevYear: "&laquo;" # <<
      nextYear: "&raquo;" # >>
      today: "今日"
      month: "月"
      week: "週"
      day: "日"
    # 月名称
    monthNames: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]    
    # 月略称
    monthNamesShort: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]    
    # 曜日名称
    dayNames: ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]    
    # 曜日略称
    dayNamesShort: ["日", "月", "火", "水", "木", "金", "土"]    