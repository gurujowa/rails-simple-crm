module TaskTypesHelper
  
    def options_task_type(default= nil)
        users = TaskType.all()
        options = options_from_collection_for_select(users, :id, :name, :selected=> default)
        return options
    end

end
