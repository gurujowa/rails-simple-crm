json.array!(@teachers) do |teacher|
  json.extract! teacher, :first_kanji, :last_kanji, :first_kana, :last_kana, :work_possible, :genre, :memo
  json.url teacher_url(teacher, format: :json)
end
