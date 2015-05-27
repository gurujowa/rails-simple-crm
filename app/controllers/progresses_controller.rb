class ProgressesController < ApplicationController
  protect_from_forgery with: :null_session
  rescue_from Exception, with: :handle_error

  def handle_error
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render json: { error: 'error' }, status: 500
  end

  def index
    Slim::Engine.with_options(options()) do
      render :index, layout: true
    end
  end

  def update_period
    begin

      if params[:name] == "teacher"
        val = Teacher.find(params[:new_value])
      else
        val = params[:new_value]
      end

      period = Period.find(params[:id])
      if period.update_attributes({params[:name] => val})
        render text: "正しく更新されました" , status: 200
      else
        render text: "更新に失敗しました。" + period.errors.full_messages.to_s , status: 500
      end
    rescue => e
      render text: "error:" + e.message , status: 500
    end
  end

  def update
    course = Course.find(params[:id])

    if params[:name] == "teacher"
      val = Teacher.find(params[:new_value])
    else
      val = params[:new_value]
    end
    
    if course.update_attributes({params[:name] => val})
      render text: "正しく更新されました" , status: 200
    else
      render text: "更新に失敗しました。" + course.errors.full_messages.to_s , status: 500
    end
  end

  def data
    @courses = Course.all
    render format: :json
  end

  def period
    @periods = Period.where(course_id: params[:id])
    render format: :json
  end


  def options
    { attr_list_delims: {'(' => ')', '[' => ']'}}
  end
end
