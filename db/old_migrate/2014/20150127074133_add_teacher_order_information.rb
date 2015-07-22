class AddTeacherOrderInformation < ActiveRecord::Migration
  def up
    add_column :teacher_orders, :mention, :text
    remove_column :teacher_orders, :course_mention, :text
    add_column :courses, :total_time_minute, :integer
    add_column :courses, :total_time_manual_flg, :boolean
    

    
    tos = TeacherOrder.all

    tos.each do |to|
      to.mention = "テキスト、レジュメ等は研修日の１週間前までに下記にお送りください。
また、レジュメとともに、必要な備品（ホワイトボード、プロジェクタなど）もお知らせください。
送り先： kenshu@yourbright.co.jp　山下勇登　宛
連絡先：　03-6908-6143（代）　090-8276-3312(山下携帯)"

      to.save!(:validate => false)
    end

  end

  def down
    remove_column :teacher_orders, :mention
    add_column :teacher_orders, :course_mention, :text
    remove_column :courses, :total_time_manual_flg
    remove_column :courses, :total_time_minute
  end
end
