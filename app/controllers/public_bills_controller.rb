class PublicBillsController < ApplicationController
  before_action :set_public_bill, only: [:show, :edit, :update, :destroy]

  # GET /public_bills
  def index
    @public_bills = PublicBill.all
  end

  # GET /estimates/1
  def show
    @until = 10 - @public_bill.public_bill_lines.length
    respond_to do |format|
      format.html { 
        redirect_to :id => params[:id],:debug => true, :format => :pdf, controller: :public_bills, action: :show
      }
      format.pdf {
        render pdf: @public_bill.name  + " - 見積書",
               encoding: 'UTF-8',
               layout: 'pdf.html',
               show_as_html: params[:debug].present?
      }
    end
  end

  # GET /public_bills/new
  def new
    @public_bill = PublicBill.new
  end

  # GET /public_bills/1/edit
  def edit
  end

  # POST /public_bills
  def create
    @public_bill = PublicBill.new(public_bill_params)

    if @public_bill.save
      redirect_to public_bills_url, notice: 'Public bill was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /public_bills/1
  def update
    if @public_bill.update(public_bill_params)
      redirect_to public_bills_url, notice: 'Public bill was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /public_bills/1
  def destroy
    @public_bill.destroy
    redirect_to public_bills_url, notice: 'Public bill was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_bill
      @public_bill = PublicBill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def public_bill_params
      params.require(:public_bill).permit(:name, :publish_date, :send_flg,
      :company_name, :invoice_date, :payment_date, :memo, :public_bill_lines_attributes => [:id, :name, :detail, :unit_price, :quantity, :tax_rate, :_destroy])
    end
end
