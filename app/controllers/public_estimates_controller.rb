class PublicEstimatesController < ApplicationController
  before_action :set_public_estimate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /public_estimates
  def index
    @public_estimates = PublicEstimate.all
  end

  # GET /public_estimates/1
  def show
    @until = 10 - @public_estimate.public_estimate_lines.length
    respond_to do |format|
      format.html { 
        redirect_to :id => params[:id],:debug => true, :format => :pdf, controller: :public_estimates, action: :show
      }
      format.pdf {
        render pdf: @public_estimate.client_name  + " - 見積書",
               encoding: 'UTF-8',
               layout: 'pdf.html',
               show_as_html: params[:debug].present?
      }
    end
  end

  # GET /public_estimates/new
  def new
    @public_estimate = PublicEstimate.new
    if params[:client_id].present?
      @public_estimate.client_id = params[:client_id]
    end
  end

  # GET /public_estimates/1/edit
  def edit
  end

  # POST /public_estimates
  def create
    @public_estimate = PublicEstimate.new(public_estimate_params)

    if @public_estimate.save
      redirect_to public_estimates_url, notice: 'public_estimate was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /public_estimates/1
  def update
    if @public_estimate.update(public_estimate_params)
      redirect_to public_estimates_url, notice: 'public_estimate was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /public_estimates/1
  def destroy
    @public_estimate.destroy
    redirect_to public_estimates_url, notice: 'public_estimate was successfully destroyed.'
  end

  def flag
    remote_flag PublicEstimate
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_estimate
      @public_estimate = PublicEstimate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def public_estimate_params
      params.require(:public_estimate).permit(:title, :display_name, :client_type, :client_id, :expired,  :send_flg, :memo,
           public_estimate_lines_attributes: [:id, :name, :unit_price, :quantity, :_destroy, :tax_rate, :detail])
    end
end
