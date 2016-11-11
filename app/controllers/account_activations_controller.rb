class AccountActivationsController < ApplicationController
  def edit
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      login_user
      flash[:success] = I18n.t(".account_activated")
      redirect_to user
    else
      flash[:danger] = I18n.t(".invalid")
      redirect_to root_url
    end
  end
end
