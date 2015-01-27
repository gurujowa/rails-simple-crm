class CoursesController < ApplicationController  
  before_action :authenticate_user!
  
  def index
    @courses = Course.all    
  end

  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html {
      }
      format.xls {
        book = Spreadsheet.open 'config/spreadsheet/export.xls'
        sheet = book.worksheet 0
        update_row @course , sheet
        data = StringIO.new
        book.write data
        send_data( data.string, :type => 'application/vnd.ms-excel', :filename => @course.company.name + ".xls")
      }
    end
  end

  def update_row c,sheet
    idx = 1

    user = c.user.email if c.user.present?

    sheet.update_row idx, idx, "/", "", "発注書の作成", c.wrike_flg("order_flg"), "Normal", user, c.start_date.ago(30.day),"","","",c.start_date.ago(30.day),"","",""
    idx += 1

    sheet.update_row idx, idx, "/", "", "出欠表の作成", c.wrike_flg("attendee_table_flg"), "Normal", user, c.start_date.ago(14.day),"","","",c.start_date.ago(7.day),"","",""
    idx += 1

    bihin_start_date = c.start_date.ago(7.day)
    sheet.update_row idx, idx, "/", "", "備品の確認", c.periods.first.wrike_flg("equipment_flg"), "Normal", user, bihin_start_date,"","","",bihin_start_date,"","",""
    idx += 1

    sheet.update_row idx, idx, "/", "", "修了証の作成", c.wrike_flg("diploma_flg"), "Normal", user, c.end_date.ago(14.day),"","","",c.end_date.ago(3.day),"","",""
    idx += 1

    c.periods.each_with_index do |p, i|
      name = "第"+ (i+1).to_s + "回研修(" + p.teacher.name + ")"
      sheet.row(idx).push idx, "/", "", name, "Active", "Normal", user, p.day,"",p.total_time_format,"",p.day,"","",p.memo
      idx += 1
      sheet.row(idx).push idx, "/", name, "レジュメの送付", p.wrike_flg("resume_flg"), "Normal", user, p.day.ago(7.day),"",p.total_time_format,"",p.day.ago(5.day),"","",""
      idx += 1
      sheet.row(idx).push idx, "/", name, "実施報告書の回収", p.wrike_flg("report_flg"), "Normal", user, p.day,"",p.total_time_format,"",p.day.since(3.day),"","",""
      idx += 1
      sheet.row(idx).push idx, "/", name, "出欠表の回収", p.wrike_flg("attend_flg"), "Normal", user, p.day,"",p.total_time_format,"",p.day.since(7.day),"","",""
      idx += 1
    end


  end

  def edit
    @course = Course.find(params[:id])
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
              e.summary     = c.company.client_name + "(" + p.teacher.name + ")"
              e.description = %Q{会社名:#{c.company.client_name}\n講師名:#{p.teacher.name}}
            end
          end
        end
      }
    end
  end

  def observe
    @courses = Course.all
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
    params.require(:course).permit(:name, :students,:user_id, :address, :tel, :station, :responsible, :company_id, :order_flg, :book_flg, :memo,  :attendee_tabile_flg,
  :diploma_flg, :total_time_manual_flg, :total_time_minute, :observe_flg, periods_attributes: [:id, :day, :start_time, :end_time, :break_start, :break_end, :teacher_id,:user_id,
       :memo, :_destroy, :resume_flg, :equipment_flg, :attend_flg, :report_flg])
  end

end
