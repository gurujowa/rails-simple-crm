class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  # GET /teachers
  def index
    @teachers = Teacher.order("last_kana ASC, first_kana ASC")
  end

  def flag
    @teachers = Teacher.order("last_kana ASC, first_kana ASC")
  end

  # GET /teachers/1
  def show
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      redirect_to teachers_url, notice: 'Teacher was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /teachers/1
  def update
    if @teacher.update(teacher_params)
      redirect_to teachers_url, notice: 'Teacher was successfully updated.'
    else
      render action: 'edit'
    end
  end
  
  def up_bool
    teacher = Teacher.find(params[:id])
    type = params[:type]
    
    set_value = reverse_bool(teacher.read_attribute(type))
    teacher[type] = set_value
        
    if teacher.save
      @teacher = teacher
      @type = type
      @bool = set_value
    else
       render json: teacher.errors, status: :unprocessable_entity
    end    
  end

  # DELETE /teachers/1
  def destroy
    @teacher.destroy
    redirect_to teachers_url, notice: 'Teacher was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def teacher_params
      params.require(:teacher).permit(:first_kanji, :last_kanji, :first_kana, :last_kana, :work_possible, :genre, :memo)
    end
end
