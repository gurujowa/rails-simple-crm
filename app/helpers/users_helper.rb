module UsersHelper
      
      def options_from_users(selected_id = nil, currents = false)
        users = User.where(id: [13,25,29])
        if selected_id.blank? and currents == true
          selected_id = current_user.id
        end
        options = options_from_collection_for_select(users, :id, :name, :selected=>selected_id)
        return options
      end
      

      def get_user_name(id)
        if id.present?
          user = User.find(id)
          return user.name
        else
          return ""
        end
      end

end
