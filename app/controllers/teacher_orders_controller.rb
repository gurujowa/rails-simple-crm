class TeacherOrdersController < ApplicationController
  before_action :set_teacher_order, only: [:show, :edit, :update, :destroy]
  before_action :set_default_form, only: [:edit, :update, :new, :create]

  # GET /teacher_orders
  def index
    @teacher_orders = TeacherOrder.all
  end

  # GET /teacher_orders/1
  def show
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
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_order
      @teacher_order = TeacherOrder.find(params[:id])
    end
    
  private
   def set_default_form
      @select_courses = Course.all
      @select_companies = Company.joins(:course).group(:client_name)     
      @teachers = Teacher.where.not(work_possible:Teacher.work_possible_hash[:impossible]).order("last_kana ASC")
   end

    # Only allow a trusted parameter "white list" through.
    def teacher_order_params
      params.require(:teacher_order).permit(
      :teacher_id, :unit_price, :memo, :invoice_flg, :payment_flg, :payment_term, :memo, :order_date, :payment_date, course_ids: [])
    end
end
