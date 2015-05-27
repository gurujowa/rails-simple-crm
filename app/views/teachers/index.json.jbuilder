json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :name, :first_kanji, :last_kanji, :first_kana, :last_kana, :work_possible, :genre, :memo
  json.url teacher_url(teacher, format: :json)
end
