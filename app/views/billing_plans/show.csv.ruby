require 'csv'
require 'nkf'
output = CSV.generate do |csv|
  csv << %w(収支区分 管理番号 発生日 支払期日 取引先 勘定科目 税区分 金額 税計算区分 税額 備考 品目 部門 メモタグ（複数指定可、カンマ区切り） 支払日 支払口座 支払金額)
  @billing_plan.billing_plan_lines.each_with_index do |l, index|
    csv << ["収入",
    "SKY"+@billing_plan.id.to_s,
    l.bill_date,
    l.accural_date,
    @billing_plan.client_name,
    "売上高",
    "課対仕入8%",
    l.price,
    "内税",
    "",
    l.memo,
    "",
    "",
    ""
    ]
  end
end

NKF::nkf('--sjis -Lw', output)
