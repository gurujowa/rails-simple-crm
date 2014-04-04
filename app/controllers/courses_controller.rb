class CoursesController < ApplicationController  
  before_action :authenticate_user!
  
  def index
    @courses = Course.all    
  end
  
  def edit
    @course = Course.find(params[:id])
#    @course.address = @course.company.getAddress if @course.address.blank?
#    @course.tel = @course.company.tel if @course.tel.blank?
#    @course.responsible = @course.company.clients.first.name if @course.responsible.blank? and @course.company.clients.present?
  end

  def alert
    @alerts = Alert.check
  end

  def task
    @alerts = Alert.task
  end
  
  def calendar
    @courses = Course.all
    @periods = Period.all
  end
  
  def update
    @course = Course.find(params[:id])
    @course.assign_attributes(course_params)

    if @course.save
      flash[:notice] = 'コース情報を変更しました'
      redirect_to :action=> 'edit', :id => params[:id]
    else
      flash[:alert] = '入力内容にエラーがあります'
      render "edit"
    end
  end
  
  def create
     @course = Course.new(course_params)     
     if @course.save
        flash[:notice] = @course.name + 'を追加しました。'
     else
       flash[:alert] = @course.errors.full_messages.join(',')
     end
     redirect_to :controller => "companies", :action => "edit", :id => @course.company_id
  end

  def new
    @course = Course.new
  end

  def up_name
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
       head :no_content
    else
       render json: @course.errors, status: :unprocessable_entity
    end
  end
  
  def up_bool
    @course = Course.find(params[:id])
    @type = params[:type]
    @bool = reverse_bool(@course.read_attribute(@type))
    if @course.update_attributes({@type => @bool})
    else
       render json: @course.errors, status: :unprocessable_entity
    end    
    
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = 'コース情報を削除しました'
    redirect_to :action=> 'index'
  end


  private
  def course_params
    params.require(:course).permit(:name, :address, :tel, :station, :responsible, :company_id, :order_flg, :book_flg, :report_flg, 
    :end_report_flg, :diploma_flg, periods_attributes: [:id, :day, :start_time, :end_time, :break_start, :break_end, :teacher_id,
       :memo, :_destroy, :resume_flg, :equipment_flg, :attend_flg, :report_flg])
  end

end
