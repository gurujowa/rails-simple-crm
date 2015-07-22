class AddCategoryTagFromLeads < ActiveRecord::Migration
  def up
    leads = Lead.all
    leads.each do |lead|
      memo = lead.memo
      me =  memo.match(/カテゴリ：(.+)/)
      if me.present?
        lead.tag_list.add(me[1])
        lead.save
      end
    end
  end
end
