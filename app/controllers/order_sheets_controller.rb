class OrderSheetsController < ApplicationController
  before_action :set_order_sheet, only: [:show, :edit, :update, :report, :destroy, :check]
  before_action :set_form_val, only: [:edit,:update,:new,:create]
  before_action :authenticate_user!

  # GET /teacher_orders
  def index
    @order_sheets = OrderSheet.all

    respond_to do |format|
      format.html
      format.csv { send_csv @order_sheets.to_csv }
    end
  end

  def new
    if params[:dup_id].present?
      parent = OrderSheet.find(params[:dup_id])
      clone = parent.deep_clone({:include => [:order_sheet_lines]})
      @order_sheet = clone
    else
      @order_sheet = OrderSheet.new
    end

    @order_sheet.mention = "テキスト、レジュメ等は研修日の１週間前までに下記にお送りください。
また、レジュメとともに、必要な備品（ホワイトボード、プロジェクタなど）もお知らせください。
送り先： kenshu@yourbright.co.jp　研修部　宛
連絡先：　03-6908-6143（代）　繋がらない場合：090-8276-3312(山下携帯)"
  end

  def create
    @order_sheet = OrderSheet.new(order_sheet_params)

    if @order_sheet.save
      redirect_to order_sheets_url, notice: '発注書が作成されました'
    else
      render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @order_sheet.update(order_sheet_params)
      redirect_to @order_sheet, notice: '発注書が更新されました'
    else
      render action: 'edit'
    end
  end

  def report
    @until = 10 - @order_sheet.order_sheet_lines.length
    respond_to do |format|
      format.html { 
        redirect_to :id => params[:id],:debug => true, :format => :pdf, action: :report
      }
      format.pdf {
        render pdf: @order_sheet.title + " - 発注書",
               encoding: 'UTF-8',
               zoom: "0.9",
               layout: 'pdf.html',
               no_background: false,
               show_as_html: params[:debug].present?
      }
    end
  end
  
  def check
    if @order_sheet.update({status:  params[:status]})
      @order_sheet.update! order_date: Date.today
      redirect_to order_sheet_url(@order_sheet), notice: '発注書を発行しました。'
    else
      redirect_to order_sheet_url(@order_sheet), error: '発注書の発行に失敗しました。'
    end
  end

  def destroy
    @order_sheet.destroy
    redirect_to order_sheets_url, notice: '削除しました'
  end

  def line
    @order_sheet_lines = OrderSheetLine.all
  end

  private
  def set_order_sheet
    @order_sheet = OrderSheet.find(params[:id])
  end

  def set_form_val
    @courses = Course.all
    @teachers = Teacher.all

  end

  def order_sheet_params
    params.require(:order_sheet).permit(
    :title,:order_date, :company_info, :mention, :memo, :send_to, :course_info,
    order_sheet_lines_attributes: [:invoice_date, :payment_date,:id,:price, :memo, :_destroy]
    )
  end

end
