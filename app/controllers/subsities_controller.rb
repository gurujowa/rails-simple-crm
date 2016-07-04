class SubsitiesController < ApplicationController
  before_action :set_subsity, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  

  # GET /subsities
  def index
    @subsities = Subsity.all
      respond_to do |format|
        format.html
        format.csv { send_csv LeadTask.to_csv }
      end
  end

  # GET /subsities/1
  def show
  end

  # GET /subsities/new
  def new
    @subsity = Subsity.new
  end

  # GET /subsities/1/edit
  def edit
  end

  # POST /subsities
  def create
    @subsity = Subsity.new(subsity_params)

    if @subsity.save
      redirect_to subsities_url, notice: 'Subsity was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /subsities/1
  def update
    if @subsity.update(subsity_params)
      redirect_to subsities_url, notice: 'Subsity was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /subsities/1
  def destroy
    @subsity.destroy
    redirect_to subsities_url, notice: 'Subsity was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subsity
      @subsity = Subsity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subsity_params
      params.require(:subsity).permit(:name, :trello_board, :trello_list,subsity_tasks_attributes: [:name, :depend,:month,:day,:_destroy,:id])
    end
end
