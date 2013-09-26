class TeacherOrdersController < ApplicationController
  before_action :set_teacher_order, only: [:show, :edit, :update, :destroy]
  before_action :set_default_form, only: [:edit, :update, :new, :create]

  # GET /teacher_orders
  def index
    @teacher_orders = TeacherOrder.all
  end

  # GET /teacher_orders/1
  def show
    report = Report.new "gyoumu.xls"

    company = @teacher_order.courses.first.company
    price_string = "金" + @teacher_order.unit_price.to_s + "/1h  X  " + (@teacher_order.total_time / 60).to_s + "h"
    if @teacher_order.additional_price.present?
      price_string << " + " + @teacher_order.additional_price.to_s + "円"
    end

    report.cell("F5","平成25年1月1日")
    report.cell("B7",@teacher_order.teacher.name)
    report.cell("D15",@teacher_order.id)
    report.cell("D17",company.full_address)
    report.cell("D18",company.client_name)
    report.cell("D19",company.tel)
    report.cell("D20",company.client_person)
    report.cell("D21",company.full_address)
    report.cell("D24",@teacher_order.start_date.strftime("%Y年%m月%d日") + "から")
    report.cell("D25",@teacher_order.end_date.strftime("%Y年%m月%d日") + "まで")
    report.cell("F24","全" + @teacher_order.total_period.to_s + "回")
    report.cell("D26",price_string)
    report.cell("D31",@teacher_order.students.to_s + "名")
    report.cell("D32",@teacher_order.description)
    ind = 1
    @teacher_order.courses.each do |courses|
      courses.periods.each do |c|
        index_string =  "[ " + (ind).to_s + " ]"
        value_string =  c.day.strftime("%Y年%m月%d日") + " " + c.start_time.strftime("%R") + "～" + c.end_time.strftime("%R")
        report.cell("C"+(34+ind).to_s, index_string)
        report.cell("D"+(34+ind).to_s, value_string)
        ind += 1
      end
    end


    send_file report.write  , :type=>"application/ms-excel", :filename => "name.xls"

  end



  # GET /teacher_orders/new
  def new
    @teacher_order = TeacherOrder.new
  end

  # GET /teacher_orders/1/edit
  def edit
    @collection_courses = @collection_courses.where("company_id = ?",@teacher_order.courses.first.company_id)
    @collection_courses.concat(@teacher_order.courses)
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
    @collection_courses = @collection_courses.where("company_id = ?",@teacher_order.courses.first.company_id)
    @collection_courses.concat(@teacher_order.courses)


    if @teacher_order.update(teacher_order_params)
      redirect_to teacher_orders_url, notice: 'Teacher order was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /teacher_orders/1
  def destroy
    Course.where(teacher_order_id: @teacher_order.id).update_all("teacher_order_id = null")
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
    @teachers = Teacher.where.not(work_possible:Teacher.work_possible_hash[:impossible]).order("last_kana ASC")
    @collection_courses = Course.where("teacher_order_id is null")
  end

    # Only allow a trusted parameter "white list" through.
  def teacher_order_params
    params.require(:teacher_order).permit(
    :teacher_id,:additional_price, :unit_price, :memo, :invoice_flg, :payment_flg, :payment_term, :memo, :order_date, :payment_date, course_ids: [])
  end



end
