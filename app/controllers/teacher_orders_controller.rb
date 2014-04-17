class TeacherOrdersController < ApplicationController
  before_action :set_teacher_order, only: [:show, :edit, :update, :destroy]
  before_action :set_default_form, only: [:edit, :update, :new, :create]
  before_action :authenticate_user!

  # GET /teacher_orders
  def index
    @teacher_orders = TeacherOrder.all
  end

  # GET /teacher_orders/1
  def show
    report = Report.new "gyoumu.xls"

    company = @teacher_order.courses.first.company
    price_string = ActionController::Base.helpers.number_to_currency(@teacher_order.price) 
    if @teacher_order.price_detail.present?
      price_string << "(" + @teacher_order.price_detail.to_s + ")"
    end

    report.cell("F5",Date.today.strftime('%Y年%m月%d日'))
    if @teacher_order.teacher.director_name
      report.cell("B7",@teacher_order.teacher.director_name + "様")
    else
      report.cell("B7",@teacher_order.teacher.short_name + "様")
    end
    report.cell("D15",@teacher_order.id)
    report.cell("D17",company.full_address)
    report.cell("D18",company.client_name)
    report.cell("D19",company.tel)
    report.cell("D20",company.client_person)
    report.cell("D21",@teacher_order.course_address)
    report.cell("D22",@teacher_order.course_station)
    report.cell("D24",@teacher_order.start_date.strftime("%Y年%m月%d日") + "から")
    report.cell("D25",@teacher_order.end_date.strftime("%Y年%m月%d日") + "まで")
    report.cell("F24","全" + @teacher_order.total_period.to_s + "回")
    report.cell("D26",price_string)
    report.cell("D31",@teacher_order.students.to_s + "名")
    report.cell("D32",@teacher_order.teacher.short_name)
    report.cell("D35",@teacher_order.course_responsible)
    report.cell("D36",@teacher_order.course_tel)
    ind = 1
    @teacher_order.course_where.each do |c|
        index_string =  "[ " + (ind).to_s + " ]"
        value_string =  c.day.strftime("%Y年%m月%d日") + " " + c.start_time.strftime("%R") + "～" + c.end_time.strftime("%R")
        report.cell("C"+(36+ind).to_s, index_string)
        report.cell("D"+(36+ind).to_s, value_string)
        ind += 1
      end

    filename = "【" + @teacher_order.teacher.name + "】講師依頼書_" + Date.today.strftime('%Y%m%d') + "_" + company.client_name + ".xls"

    @teacher_order.update_attributes!({:order_date => Date.today})
    send_file report.write  , :type=>"application/ms-excel", :filename => filename
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
      redirect_to teacher_orders_url, notice: 'Teacher order was successfully updated.'
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
    :teacher_id,:price, :price_detail, :memo, :invoice_flg,:students, :description,
    :payment_flg, :payment_term, :memo, :order_date, :payment_date, course_ids: [])
  end

end
