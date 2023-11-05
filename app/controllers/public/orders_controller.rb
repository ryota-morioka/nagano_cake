class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @cart_items = current_customer.cart_items
  end

  def confirm
    @order = Order.new(order_params)
    @order.shipping_address = current_customer.address
    @cart_items = current_customer.cart_items
  end

  def order_finish
    @order = Order.new(order_params)
    @order.shipping_address = current_customer.address
    @order.save
    current_customer.cart_items.destroy_all
    redirect_to order_finish_orders_path
  end

  def create
    @order = Order.new(order_params)
    @order.shipping_address = current_customer.address
    @order.save
    current_customer.cart_items.destroy_all
    redirect_to orders_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:shipping_method_id, :shipping_address_id, :payment_method_id, :total_price)
  end

end
