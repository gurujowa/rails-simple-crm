class CoursesController < ApplicationController  
  before_action :authenticate_user!
  
  def index
    @courses = Course.all    
  end

  def show
    @course = Course.find(params[:id])
    @tasks = Task.where(course_id: @course.id)
  end

  def edit
    @course = Course.find(params[:id])
  end


  def google
    gcal = Gcalendar.new
    result = gcal.api

    if result.success?
      render json: result.data
    else
      render json: {error: result.error_message}
    end
  end

  
  def calendar
    @courses = Course.all
    @periods = Period.all

    respond_to do |format|
      format.html {
      }
      format.json{
      }
      format.ics {
        @cal = Icalendar::Calendar.new
        @courses.each do |c|
          c.periods.each do |p|
            @cal.event do |e|
              e.dtstart     = Icalendar::Values::DateTime.new(p.start_date)
              e.dtend       = Icalendar::Values::DateTime.new(p.end_date)
              e.summary     = c.lead.name + "(" + p.teacher.name + ")"
              e.description = %Q{会社名:#{c.lead.name}\n講師名:#{p.teacher.name}}
            end
          end
        end
      }
    end
  end

  def progress
    @periods = Period.where(id: 0..10)
  end

  def progress_update
    params[:q].each do |q|
      pq = PeriodProgress.new( q[1] )
      pq.update
    end

    render json: {success: "更新が完了しました"}
  end

  def list
    c = Course.all
    csvs = CSV.generate do |csv|
      csv << ["コマID","講師名","登壇日","開始時刻","終了時刻","コース名","企業名","メモ"]
      c.each do |c|
        c.periods.each do |period|
          csv << [period.id,period.teacher.name,period.day,period.start_date.to_s(:time),period.end_date.to_s(:time),c.name,c.lead.name, period.memo]
        end
      end
    end
    respond_to do |format|
      format.csv { send_csv csvs }
    end

  end


  def update
    @course = Course.find(params[:id])
    @course.assign_attributes(course_params)

    if @course.save
      flash[:notice] = 'コース情報を変更しました'
      redirect_to :action=> 'show', :id => params[:id]
    else
      flash[:alert] = '入力内容にエラーがあります'
      render "edit"
    end
  end
  
  def create
     @course = Course.new(course_params)     
     if @course.save
        flash[:notice] = @course.name + 'を追加しました。'
        redirect_to :controller => "courses", :action => "show", :id => @course.id
     else
       flash[:alert] = @course.errors.full_messages.join(',')
       render "new"
     end
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
    params.require(:course).permit(:name, :students,:user_id, :address, :tel, :station, :responsible,  :memo,  :lead_id,
        periods_attributes: [:id, :day, :start_time, :end_time, :break_start, :break_end, :teacher_id,:user_id, :memo, :_destroy],
        tasks_attributes: [:id, :day, :name,:memo, :_destroy]
        )
  end

end
