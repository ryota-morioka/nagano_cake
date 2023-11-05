class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    search = params[:search]

    if search == "waiting_for_payment"
      @orders = Order.page(params[:page]).where(order_status: 0).order(created_at: "DESC")
    elsif search == "payment_confirmation"
      @orders = Order.page(params[:page]).where(order_status: 1).order(created_at: "DESC")
    elsif search == "now_at_work"
      @orders = Order.page(params[:page]).where(order_status: 2).order(created_at: "DESC")
    elsif search == "shipping_preparation"
      @orders = Order.page(params[:page]).where(order_status: 3).order(created_at: "DESC")
    end
  end
end
