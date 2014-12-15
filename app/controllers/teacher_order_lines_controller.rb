class TeacherOrderLinesController < ApplicationController
  before_action :authenticate_user!

  # GET /billing_plans
  def index
    @teacher_order_lines = TeacherOrderLine.all

    respond_to do |format|
      format.html
      format.csv { render text: @teacher_order_lines.to_csv.tosjis }
    end
  end

  def flag
    remote_flag TeacherOrderLine
  end

end
