module UsersHelper
      def options_from_collection_for_select(collection, value_method, text_method, selected = nil)
        options = collection.map do |element|
          [element.send(text_method), element.send(value_method)]
        end
        selected, disabled = extract_selected_and_disabled(selected)
        select_deselect = {}
        select_deselect[:selected] = extract_values_from_collection(collection, value_method, selected)
        select_deselect[:disabled] = extract_values_from_collection(collection, value_method, disabled)

        options_for_select(options, select_deselect)
      end

      def options_from_users(selected = nil)
        collection = User.all.unshift(User.new)
        options = collection.map do |element|
          [element.send('name'), element.send('id')]
        end
        selected, disabled = extract_selected_and_disabled(selected)
        select_deselect = {}
        select_deselect[:selected] = extract_values_from_collection(collection, "id", selected)
        select_deselect[:disabled] = extract_values_from_collection(collection, "id", disabled)

        options_for_select(options, select_deselect)
      end
      
      def get_user_name(id)
        user = User.find(id)
        return user.name
      end

end
