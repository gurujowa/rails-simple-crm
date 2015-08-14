class OrderSheetLinesController < ApplicationController
  before_action :authenticate_user!

  # GET /billing_plans
  def index
    @order_sheet_lines = OrderSheetLine.all

    respond_to do |format|
      format.html
      format.csv { render text: @order_sheet_lines.to_csv }
    end
  end

  def flag
    remote_flag OrderSheetLine
  end

end
