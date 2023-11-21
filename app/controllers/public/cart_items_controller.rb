class Public::CartItemsController < ApplicationController
before_action :authenticate_customer!

  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum { |item| item.subtotal }
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item.blank?
      @cart_item = current_customer.cart_items.build(item_id: params[:cart_item][:item_id], amount: params[:cart_item][:amount])
    else
      @cart_item.amount += params[:cart_item][:amount].to_i
    end
    if @cart_item.save
      redirect_to cart_items_path, notice: "商品を追加しました"
    else
      @item = Item.find_by(id: params[:cart_item][:item_id])
      redirect_to item_path(@item.id), alert: "購入数を選択してください。"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to request.referer, notice: "商品の個数を変更しました"
    else
      render 'index'
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      redirect_to request.referer, notice: "商品を削除しました"
    else
      render 'index'
    end
  end

  def destroy_all
    if current_customer.cart_items.destroy_all
      redirect_to request.referer, notice: "商品を全て削除しました"
    else
      render 'index'
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end

end