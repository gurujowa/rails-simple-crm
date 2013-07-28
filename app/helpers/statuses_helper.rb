module StatusesHelper
  
  def get_status_name(id)
      status = Status.find(id)
      return status.name
  end
  
  
  def options_from_statuses(selected = nil, show_deprecated = false)
    if show_deprecated == true
      collection = Status.all.unshift(Status.new)
    else 
      collection = Status.where(active: true).order("rank DESC").unshift(Status.new)
    end
    options = collection.map do |element|
      [element.send('name'), element.send('id')]
    end
    selected, disabled = extract_selected_and_disabled(selected)
    select_deselect = {}
    select_deselect[:selected] = extract_values_from_collection(collection, "id", selected)
    select_deselect[:disabled] = extract_values_from_collection(collection, "id", disabled)

    options_for_select(options, select_deselect)
  end
      
      
end
