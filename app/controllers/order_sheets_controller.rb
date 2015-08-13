class OrderSheetsController < ApplicationController
  before_action :set_order_sheet, only: [:show, :edit, :update, :report, :destroy, :check]
  before_action :set_form_val, only: [:edit,:update,:new,:create]
  before_action :authenticate_user!

  # GET /teacher_orders
  def index
    @order_sheets = OrderSheet.all
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
        render pdf: @order_sheet.title + " - 業務依頼書",
               encoding: 'UTF-8',
               zoom: "0.9",
               layout: 'pdf.html',
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
=begin
  def line
    @teacher_order_lines = TeacherOrderLine.all
  end


  def cancel
    if @teacher_order.update({status:  "cancel"})
      redirect_to teacher_order_url(@teacher_order), notice: '講師発注をキャンセルしました。'
    else
      redirect_to teacher_order_url(@teacher_order), error: '講師発注のキャンセルに失敗しました。'
    end
  end

  def active
    if @teacher_order.update({status:  "active"})
      @teacher_order.update! order_date: Date.today
      redirect_to teacher_order_url(@teacher_order), notice: '講師発注を発行しました。'
    else
      redirect_to teacher_order_url(@teacher_order), error: '講師発注の発行に失敗しました。'
    end
  end

  def report
    @to = @teacher_order
    @until = 10 - @teacher_order.teacher_order_lines.length
    respond_to do |format|
      format.html { 
        redirect_to :id => params[:id],:debug => true, :format => :pdf, controller: :teacher_orders, action: :report
      }
      format.pdf {
        render pdf: @teacher_order.teacher.name + " - " + @teacher_order.lead_name + " - 業務依頼書",
               encoding: 'UTF-8',
               zoom: "0.9",
               layout: 'pdf.html',
               show_as_html: params[:debug].present?
      }
    end
  end


  def flag
    @to = TeacherOrder.find(params[:id])

    if (@to.update_attributes({params[:type] => Date.today}))
      render_noty :success, "フラグの変更が完了しました。", %Q{$('#td_teacher_order_#{params[:type]}_#{params[:id]}').html("#{Date.today.strftime("%Y-%m-%d")}")}
    else
      render_noty :error, @to.errors.full_messages
    end
  end





    
  private
  def set_default_form
    @select_courses = Course.all
    @select_companies = Lead.joins(:course).group(:name)
    @teachers = Teacher.where.not(work_possible: Teacher.work_possible_hash[:impossible]).order("last_kana ASC")
  end

=end
    # Only allow a trusted parameter "white list" through.
  def order_sheet_params
    params.require(:order_sheet).permit(
    :title,:order_date, :company_info, :mention, :memo, :send_to, :course_info,
    order_sheet_lines_attributes: [:invoice_date, :payment_date,:id,:price, :memo, :_destroy]
    )
  end

end
