class Admin::UsersController < ApplicationController
  before_action :check_admin
  before_action :set_user, only: %i[show edit destroy update]

  def index
    @users = User.all.order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(admin_users_path)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to(admin_users_path)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to(admin_users_path)
    else
      redirect_to admin_users_path, notice: t('view.user.destroy_errer')
    end
  end

  private

  def check_admin
    if logged_in? # ログインしている場合
      redirect_to(root_path) unless current_user.admin? # adminでなければ、タスク一覧へリダイレクト
    else # ログインしていない場合
      redirect_to(new_session_path) # ログインページへリダイレクト
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
