class LeadEstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  

  def index
    @estimates = LeadEstimate.all
  end

  # GET /estimates/1
  def show
    @until = 10 - @estimate.lead_estimate_lines.length
    respond_to do |format|
      format.html { 
        redirect_to :id => params[:id],:debug => true, :format => :pdf, controller: :estimates, action: :show
      }
      format.pdf {
        render pdf: @estimate.lead.name  + " - 見積書",
               encoding: 'UTF-8',
               layout: 'pdf.html',
               show_as_html: params[:debug].present?
      }
    end
  end

  def new
    @estimate = LeadEstimate.new
    if params[:lead_id].present?
      @estimate.lead_id = params[:lead_id]
    end
  end

  def edit
  end

  def create
    @estimate = LeadEstimate.new(estimate_params)

    if @estimate.save
      redirect_to lead_estimates_url, notice: 'Estimate was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /estimates/1
  def update
    if @estimate.update(estimate_params)
      redirect_to lead_estimates_url, notice: 'Estimate was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /estimates/1
  def destroy
    @estimate.destroy
    redirect_to lead_estimates_url, notice: 'Estimate was successfully destroyed.'
  end

  def flag
    remote_flag LeadEstimate
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estimate
      @estimate = LeadEstimate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def estimate_params
      params.require(:lead_estimate).permit(:title, :lead_id, :expired,  :send_flg, :memo,
           lead_estimate_lines_attributes: [:id, :name, :unit_price, :quantity, :_destroy, :tax_rate, :detail])
    end
end
