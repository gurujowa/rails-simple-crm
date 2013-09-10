class CoursesController < ApplicationController  
  
  def edit
    @course = Course.find(params[:id])
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
    
    case @type
    when "order_flg"
      @course.order_flg = reverse_bool(@course.order_flg)
      @bool = @course.order_flg
    when "book_flg"
      @course.book_flg = reverse_bool(@course.book_flg)
      @bool = @course.book_flg
    when "end_report_flg"
      @course.end_report_flg = reverse_bool(@course.end_report_flg)
      @bool = @course.end_report_flg
    when "resume_flg"
      @course.resume_flg = reverse_bool(@course.resume_flg)
      @bool = @course.resume_flg
    when "report_flg"
      @course.report_flg = reverse_bool(@course.report_flg)
      @bool = @course.report_flg
    else
      raise "どのフラグを立てていいかがわかりません"
    end
    
    if @course.save
    else
       render json: @course.errors, status: :unprocessable_entity
    end    
  end

  private
  def reverse_bool(flag)
    if flag.equal?(true)
      return false
    elsif flag.equal?(false)
      return true
    else
      raise "型があっていません"
    end
  end

  private
  def course_params
    params.require(:course).permit(:name, :company_id, :order_flg, :book_flg, :report_flg, 
    :end_report_flg, periods_attributes: [:id, :day, :start_time, :end_time, :break_start, :break_end, :teacher_id,
       :memo, :_destroy, :resume_flg, :report_flg])
  end

end
