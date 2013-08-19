
TaskType.create(:name => '新規FAXフォロー', :default_due => 3, :group => "フォロー")
TaskType.create(:name => '資料請求後フォロー', :default_due => 5, :group => "フォロー")
TaskType.create(:name => 'カリキュラム作成', :default_due => 1, :group => "作成系")
TaskType.create(:name => '提案書作成', :default_due => 1, :group => "作成系")
TaskType.create(:name => '見積作成', :default_due => 1, :group => "作成系")
TaskType.create(:name => '荷電', :group => "汎用系")
TaskType.create(:name => 'アポイント',  :group => "汎用系")
TaskType.create(:name => 'その他',  :group => "汎用系")

