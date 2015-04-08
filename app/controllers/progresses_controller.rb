class ProgressesController < ApplicationController

  def index
    Slim::Engine.with_options(options()) do
      render :index, layout: true
    end
  end

  def data
    @courses = Course.all
    render format: :json
  end

  def main
    Slim::Engine.with_options(options()) do
      render :main, layout: true
    end

  end

  def options
    { attr_list_delims: {'(' => ')', '[' => ']'}}
  end
end
