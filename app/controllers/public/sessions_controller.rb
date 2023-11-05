# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def new
  end

  def create
    customer = Customer.find_by(email: params[:email])
    if customer&.authenticate(params[:password])
      session[:customer_id] = customer.id
      redirect_to root_path
    else
      flash[:danger] = "メールアドレスまたはパスワードが違います。"
      render :new
    end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to root_path
  end

end
