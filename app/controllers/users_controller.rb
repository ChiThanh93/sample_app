class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :load_user, except: [:create, :new , :index]

  def index
    @users = User.page(params[:page]).order(created_at: :ASC)
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page], per_page: 5
    render_404 unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = I18n.t(".please_check")
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = I18n.t(".profile_updated")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = I18n.t(".user_deleted")
    redirect_to users_url
  end

  def following
    @title = I18n.t(".following")
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page].order(created_at: :ASC)
    render :show_follow
  end

  def followers
    @title = I18n.t(".followers")
    @user  = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page].order(created_at: :ASC)
    render :show_follow
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    render_404 unless @user
  end
end
