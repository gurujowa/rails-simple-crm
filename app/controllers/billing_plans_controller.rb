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
        redirect_to :id => params[:id],:debug => true, :format => :pdf, controller: :billing_plans, action: :show
      }
      format.pdf {
        render pdf: @billing_plan.client_name + " - 請求予定表",
               encoding: 'UTF-8',
               layout: 'pdf.html',
               show_as_html: params[:debug].present?
      }
    end

  end

  # GET /billing_plans/new
  def new
    if params[:dup_id].present?
      parent = BillingPlan.find(params[:dup_id])
      clone = parent.deep_clone :include => :billing_plan_lines
      @billing_plan = clone
    else
      @billing_plan = BillingPlan.new
      @billing_plan.billing_plan_lines.new
      end
    if params[:lead_id].present?
      @billing_plan.lead_id = params[:lead_id]
    end
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
      params.require(:billing_plan).permit(:name, :display_name, :send_flg, :lead_id, :tax_rate, :status, :memo, :publish_date,
        billing_plan_lines_attributes: [:id,  :bill_date, :accural_date, :price,  :memo, :_destroy]
                                          )
    end
end
