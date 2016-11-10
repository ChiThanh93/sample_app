class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = I18n.t".please_log_in"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
