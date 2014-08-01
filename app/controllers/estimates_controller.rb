class EstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  

  # GET /estimates
  def index
    @estimates = Estimate.all
  end

  # GET /estimates/1
  def show
    @until = 10 - @estimate.estimate_lines.length
    respond_to do |format|
      format.html { 
        redirect_to :id => params[:id],:debug => true, :format => :pdf, controller: :estimates, action: :show
      }
      format.pdf {
        render pdf: @estimate.client_name  + " - 見積書",
               encoding: 'UTF-8',
               layout: 'pdf.html',
               show_as_html: params[:debug].present?
      }
    end
  end

  # GET /estimates/new
  def new
    @estimate = Estimate.new
    if params[:client_id].present?
      @estimate.client_id = params[:client_id]
    end
  end

  # GET /estimates/1/edit
  def edit
  end

  # POST /estimates
  def create
    @estimate = Estimate.new(estimate_params)

    if @estimate.save
      redirect_to estimates_url, notice: 'Estimate was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /estimates/1
  def update
    if @estimate.update(estimate_params)
      redirect_to estimates_url, notice: 'Estimate was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /estimates/1
  def destroy
    @estimate.destroy
    redirect_to estimates_url, notice: 'Estimate was successfully destroyed.'
  end

  def flag
    remote_flag Estimate
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estimate
      @estimate = Estimate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def estimate_params
      params.require(:estimate).permit(:title, :client_type, :client_id, :expired,  :send_flg, :memo,
           estimate_lines_attributes: [:id, :name, :unit_price, :quantity, :_destroy, :tax_rate, :detail])
    end
end
