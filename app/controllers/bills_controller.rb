class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  def index
    @bills = Bill.all
  end

  def flag
    remote_flag Bill
  end

  # GET /bills/1
  def show
    @until = 10 - @bill.bill_lines.length
    respond_to do |format|
      format.html { 
        render :layout => "pdf.html"
      }
      format.pdf {
        html = render_to_string(:layout => "pdf.html", :formats => [:html])
        kit = PDFKit.new(html)
        send_data(kit.to_pdf, :filename => "bill.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
    end
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  def create
    @bill = Bill.new(bill_params)

    if @bill.save
      redirect_to bills_url, notice: 'Bill was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bills/1
  def update
    if @bill.update(bill_params)
      redirect_to bills_url, notice: 'Bill was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def search
    @companies = Company.where("client_name like :search", search: "%#{params[:q]}%")
    ids = @companies.map(&:id)

    @line = BillingPlanLine.joins(:billing_plan)
    .where("billing_plans.company_id in (?)", ids)
    .where("billing_plans.status = :search", search: "completed")
    .order("billing_plan_lines.bill_date asc")
  end

  def find
    @line = BillingPlanLine.find(params[:id])
  end


  # DELETE /bills/1
  def destroy
    @bill.destroy
    redirect_to bills_url, notice: 'Bill was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bill_params
      params.require(:bill).permit(:name, :duedate, :billing_plan_line_id, :bill_flg, :payment_flg, :memo,
        bill_lines_attributes: [:id,  :name, :unit_price, :quantity, :tax_rate, :memo, :_destroy]
                                  )
    end
end
