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
        render :layout => "pdf.html"
      }
      format.pdf {
        html = render_to_string(:layout => "pdf.html", :formats => [:html])
        kit = PDFKit.new(html)
        send_data(kit.to_pdf, :filename => "見積書.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
    end
  end

  # GET /estimates/new
  def new
    @estimate = Estimate.new
    if params[:company_id].present?
      @estimate.company_id = params[:company_id]
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
      params.require(:estimate).permit(:title, :company_id, :expired,  :send_flg, :memo,
           estimate_lines_attributes: [:id, :name, :unit_price, :quantity, :_destroy, :tax_rate, :detail])
    end
end
