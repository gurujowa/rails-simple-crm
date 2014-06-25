class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  # GET /leads
  def index
      @q = Lead.search(params[:q])
      @leads = @q.result.includes(:lead_histories).paginate(page: params[:page],per_page: 100)
    
  end

  def search
    index
    render :index
  end

  # GET /leads/1
  def show
    @new_lead_history = LeadHistory.new
    @new_lead_history.lead_id = @lead.id
    @new_lead_history.approach_day = DateTime.now()

    @status_ing = LeadHistoryStatus.where(progress: "ing")
    @status_done = LeadHistoryStatus.where(progress: "done")
    @status_forbidden = LeadHistoryStatus.where(progress: "forbidden")
  end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads
  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to leads_url, notice: 'Lead was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      redirect_to leads_url, notice: 'Lead was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /leads/1
  def destroy
    @lead.destroy
    redirect_to leads_url, notice: 'Lead was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lead_params
      params.require(:lead).permit(:city,:name, :tel, :fax, :email, :person_name, :person_kana, :person_post, :url, :zipcode, :prefecture, :street, :building, :memo, :user_id, :star)
    end
end
