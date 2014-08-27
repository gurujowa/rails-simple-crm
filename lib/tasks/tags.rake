namespace :tags do
  desc "一括タグ追加"

  task "show" => :environment do
    leads = env_set
    p "取得数は" + leads.count.to_s
    if ENV['sql'].present?
      p leads.to_sql
    else
      leads.each do |l|
        p l.name
      end
    end
  end

  task "update" => :environment do

    leads = env_set()
    p "取得数は" + leads.count.to_s
    leads.each do |l|
      l.tag_list.add(ENV['to'])
      l.save
    end
  end

  def env_set
    leads = Lead.where(user_id: nil)

    leads = leads.where(prefecture: ENV['prefecture']) if ENV['preffecture'].present?
    leads = leads.tagged_with(ENV['tag']).tagged_with(ENV['to'],:exclude => true) if ENV['tag'].present?
    leads = leads.limit(ENV['limit']) if ENV['limit'].present?
    leads = leads.offset(ENV['offset']) if ENV['offset'].present?

    unless ENV['to'].present?
      raise "必ず引数toはつけてください"
    end

    return leads
  end
end
