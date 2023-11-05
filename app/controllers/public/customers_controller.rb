class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def confirm_withdraw
  end

  def withdraw
    @customer = current_customer
    @customer.update(status: "withdrawn")
    session[:customer_id] = nil
    redirect_to root_path
  end

  def lookup_address
    # 郵便番号から住所を検索する処理
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end

end
