class Public::CartItemsController < ApplicationController

before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.quantity = params[:quantity]
    @cart_item.save
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.new(
      product_id: @product.id,
      quantity: 1
    )
    @cart_item.save
    redirect_to cart_items_path
  end

end
