class TeacherOrdersController < ApplicationController
  before_action :set_teacher_order, only: [:report, :active, :cancel, :show, :edit, :update, :destroy]
  before_action :set_default_form, only: [:edit, :update, :new, :create]
  before_action :authenticate_user!

  # GET /teacher_orders
  def index
    @teacher_orders = TeacherOrder.all
  end

  def line
    @teacher_order_lines = TeacherOrderLine.all
  end

  def show
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
        render pdf: @teacher_order.teacher.name + " - " + @teacher_order.company.name + " - 業務依頼書",
               encoding: 'UTF-8',
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

  # GET /teacher_orders/new
  def new
    @teacher_order = TeacherOrder.new
    @teacher_order.mention = "テキスト、レジュメ等は研修日の１週間前までに下記にお送りください。
また、レジュメとともに、必要な備品（ホワイトボード、プロジェクタなど）もお知らせください。
送り先： kenshu@yourbright.co.jp　山下勇登　宛
連絡先：　03-6908-6143（代）　090-8276-3312(山下携帯)"
  end

  # GET /teacher_orders/1/edit
  def edit
  end

  # POST /teacher_orders
  def create
    @teacher_order = TeacherOrder.new(teacher_order_params)

    if @teacher_order.save
      redirect_to teacher_orders_url, notice: 'Teacher order was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /teacher_orders/1
  def update
    if @teacher_order.update(teacher_order_params)
      redirect_to @teacher_order, notice: '発注情報が更新されました'
    else
      render action: 'edit'
    end
  end

  # DELETE /teacher_orders/1
  def destroy
    @teacher_order.destroy
    redirect_to teacher_orders_url, notice: 'Teacher order was successfully destroyed.'
  end

  private
  def set_teacher_order
    @teacher_order = TeacherOrder.find(params[:id])
  end
    
  private
  def set_default_form
    @select_courses = Course.all
    @select_companies = Company.joins(:course).group(:client_name)
    @teachers = Teacher.where.not(work_possible: Teacher.work_possible_hash[:impossible]).order("last_kana ASC")
  end

    # Only allow a trusted parameter "white list" through.
  def teacher_order_params
    params.require(:teacher_order).permit(
    :teacher_id,:price, :price_detail, :order_date, :memo, :invoice_flg,:students, :description, :period_type,
    :payment_flg, :display_period_flg,:mention,  :payment_term, :memo, :order_date, :payment_date, course_ids: [],
    teacher_order_lines_attributes: [:id, :_destroy, :payment_date, :price, :memo],
    teacher_order_periods_attributes: [:id, :_destroy, :day,:start_time, :end_time, :break_start, :break_end, :memo])
  end

end
