class Public::OrdersController < ApplicationController
  include Public::OrdersHelper
  before_action :authenticate_customer!
  # before_action :cart_check, only: [:new, :confirm, :create]



  def new
    @order = Order.new
    @recipient_addresses = current_customer.recipient_addresses
  end

  def confirm
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
    customer = current_customer
    address_option = params[:order][:address_option].to_i

    @order.payment_method = params[:order][:payment_method].to_i
    @order.temporary_information_input(customer.id)

    if address_option == 0
      @order.order_in_postal_code_address_name(customer.postal_code, customer.address, customer.last_name)
    end
    # unless @order.valid?
    #   flash[:danger] = "お届け先の内容に不備があります<br>・#{@order.errors.full_messages.join('<br>・')}"
    #   p @order.errors.full_messages
    #   redirect_back(fallback_location: root_path)
    # end
    # render plain: @order.inspect
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_fee = 800
    @order.recipient_postal_code = params[:order][:recipient_postal_code]
    # カート内のアイテムを取得
    cart_items = CartItem.where(customer_id: current_customer.id)

    # 合計金額を計算
    total_amount = 0
    cart_items.each do |item|
      total_amount += item.subtotal  # subtotalは各アイテムの小計を表すメソッドと仮定
    end

    @order.billing_amount = total_amount

    if @order.save
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.purchase_price = cart_item.item.price
        if order_detail.save
          @cart_items.destroy_all
        end
      end
      redirect_to orders_thanks_path
    else

    end
  end

  def thanks
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  private

  def order_params
   params.require(:order).permit(:customer_id, :recipient_postal_code, :recipient_address, :recipient_name, :shipping_fee, :billing_amount, :payment_method)
  end
  # def cart_check
  #   unless CartItem.find_by(customer_id: current_customer.id)
  #     flash[:danger] = "カートに商品がない状態です"
  #     redirect_to root_url
  #   end
  # end

end