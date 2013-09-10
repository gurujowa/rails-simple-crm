class TasksController < ApplicationController
  before_action :set_task, :only => [:show, :edit, :update, :destroy]
  before_action :check_user

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  def usershow
    @tasks = Task.joins(:company).where(assignee: session[:current_user].id ).
    where.not(progress_id: [TaskProgress.getId(:finish),TaskProgress.getId(:canceled)]).
    order("companies.status_id asc, companies.client_name asc, tasks.duedate asc")

    respond_to do |format|
      format.html
      format.csv { render text: @tasks.to_csv.tosjis }
    end

  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end
  
  def status_change
    @task = Task.find(params[:id])
    @task.progress_id = params[:selected]
    
    if @task.save
      render :json => {'text' => 'ステータスの変更が完了しました', 'type' => 'alert', 
        'status_name' => @task.getProgress(), 'color' => @task.getBootstrapColor()}
    else
      render :json => {'text' => @task.errors.full_messages.to_sentence, 'type' => 'error'}
    end
    
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.created_by = session[:current_user].id

    respond_to do |format|
      if @task.save
        format.html { redirect_to  :action=> 'index', notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: "aaaaaa", status: :unprocessable_entity }
      end
    end
  end
  
  def ajax_create
    @task = Task.new(task_params)
    @task.created_by = session[:current_user].id
    if @task.save
    else
      logger.fatal(@task.errors.full_messages.to_sentence)
      @error = true

    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to :action=> 'index', notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { render json: @task }
      format.js {}
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:type_id, :company_id,:duedate, :name, :assignee, :created_by, :progress_id, :note)
    end
end
