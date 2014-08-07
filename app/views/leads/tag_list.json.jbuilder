json.array!(@tag_list) do |tag|
  json.id tag.id
  json.text tag.name
end
