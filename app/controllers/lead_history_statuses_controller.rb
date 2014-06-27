class LeadHistoryStatusesController < ApplicationController
  before_action :set_lead_history_status, only: [:show, :edit, :update, :destroy]

  # GET /lead_history_statuses
  def index
    @lead_history_statuses = LeadHistoryStatus.all
  end

  # GET /lead_history_statuses/1
  def show
  end

  # GET /lead_history_statuses/new
  def new
    @lead_history_status = LeadHistoryStatus.new
  end

  # GET /lead_history_statuses/1/edit
  def edit
  end

  # POST /lead_history_statuses
  def create
    @lead_history_status = LeadHistoryStatus.new(lead_history_status_params)

    if @lead_history_status.save
      redirect_to lead_history_statuses_url, notice: 'Lead history status was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /lead_history_statuses/1
  def update
    if @lead_history_status.update(lead_history_status_params)
      redirect_to lead_history_statuses_url, notice: 'Lead history status was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /lead_history_statuses/1
  def destroy
    @lead_history_status.destroy
    redirect_to lead_history_statuses_url, notice: 'Lead history status was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead_history_status
      @lead_history_status = LeadHistoryStatus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lead_history_status_params
      params.require(:lead_history_status).permit(:name, :progress, :color)
    end
end
