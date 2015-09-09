class CourseTasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = CourseTask.all
  end

  def destroy
    @task = CourseTask.find(params[:id])
    if @task.destroy
      render json: {
        text: "削除が完了しました", 
        event_id: params[:event_id],
        status: 200,
      }
    else
      render json: @task.errors.full_messages.join(',')
    end

  end

  def change
    if params[:id].present?
      @task = CourseTask.find(params[:id])
      @task.assign_attributes(course_task_params)
    else
      @task = CourseTask.new(course_task_params)
    end

    if @task.save
      render json: {
        text: "保存が完了しました", 
        event_id: params[:event_id],
        status: 200,
        title: @task.title,
        start: @task.start,
        end: @task.end,
      }
    else
      render json: @task.errors.full_messages.join(',')
    end
  end


  private
    # Only allow a trusted parameter "white list" through.
    def course_task_params
      params.require(:course_task).permit(:id, :title, :all_day, :start, :end, :memo, :course_id)
    end
end
