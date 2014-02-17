class BillingPlansController < ApplicationController
  before_action :set_billing_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /billing_plans
  def index
    @billing_plans = BillingPlan.all

    respond_to do |format|
      format.html
      format.csv { render text: @billing_plans.to_csv.tosjis }
    end
  end

  # GET /billing_plans/1
  def show
    @until = 10 - @billing_plan.billing_plan_lines.length
    respond_to do |format|
      format.html { 
        render :layout => "pdf.html"
      }
      format.pdf {
        html = render_to_string(:layout => "pdf.html", :formats => [:html])
        kit = PDFKit.new(html)
        send_data(kit.to_pdf, :filename => "billing_plan.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
    end
  end

  # GET /billing_plans/new
  def new
    @billing_plan = BillingPlan.new
    @billing_plan.billing_plan_lines.new
  end

  def sales
    @lines = BillingPlanLine.sales(Date.today)
  end

  # GET /billing_plans/1/edit
  def edit
  end

  def flag
    remote_flag BillingPlan
  end

  # POST /billing_plans
  def create
    @billing_plan = BillingPlan.new(billing_plan_params)

    if @billing_plan.save
      redirect_to billing_plans_url, notice: 'Billing plan was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /billing_plans/1
  def update
    if @billing_plan.update(billing_plan_params)
      redirect_to billing_plans_url, notice: 'Billing plan was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /billing_plans/1
  def destroy
    @billing_plan.destroy
    redirect_to billing_plans_url, notice: 'Billing plan was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing_plan
      @billing_plan = BillingPlan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def billing_plan_params
      params.require(:billing_plan).permit(:name, :company_id, :tax_rate, :status, :memo, :publish_date,
        billing_plan_lines_attributes: [:id,  :bill_date, :accural_date, :price,  :memo, :_destroy]
                                          )
    end
end