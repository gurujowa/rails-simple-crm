class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.all
  end

  private
    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:id, :name, :due_date, :complete_date, :memo, :lead_id)
    end
end
