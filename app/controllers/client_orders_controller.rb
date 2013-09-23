class ClientOrdersController < ApplicationController
  before_action :set_client_order, only: [:show, :edit, :update, :destroy]

  # GET /client_orders
  def index
    @client_orders = ClientOrder.all
  end

  # GET /client_orders/1
  def show
  end

  # GET /client_orders/new
  def new
    @client_order = ClientOrder.new
  end

  # GET /client_orders/1/edit
  def edit
  end

  # POST /client_orders
  def create
    @client_order = ClientOrder.new(client_order_params)

    if @client_order.save
      redirect_to client_orders_url, notice: 'Client order was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /client_orders/1
  def update
    if @client_order.update(client_order_params)
      redirect_to client_orders_url, notice: 'Client order was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /client_orders/1
  def destroy
    @client_order.destroy
    redirect_to client_orders_url, notice: 'Client order was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_order
      @client_order = ClientOrder.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_order_params
      params.require(:client_order).permit(:company_id, :price, :invoice_flg, :payment_flg, :invoice_date, :payment_date, :memo)
    end
end
