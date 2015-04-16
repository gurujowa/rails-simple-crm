class ProgressesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    Slim::Engine.with_options(options()) do
      render :index, layout: true
    end
  end

  def update

    course = Course.find(params[:id])
    if course.update_attributes({params[:name] => params[:new_value]})
      render text: "正しく更新されました" , status: 200
    else
      render text: "更新に失敗しました。" + course.errors.full_messages.to_s , status: 500
    end
  end

  def data
    @courses = Course.all
    render format: :json
  end

  def sub
    Slim::Engine.with_options(options()) do
      render :sub, layout: true
    end
  end

  def options
    { attr_list_delims: {'(' => ')', '[' => ']'}}
  end
end
