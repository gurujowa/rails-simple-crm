module UsersHelper
      
      def options_from_users(selected_id = nil)
        users = User.all()
        options = options_from_collection_for_select(users, :id, :name, :selected=>selected_id)
        return options
      end
      
      def select_user
        
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
