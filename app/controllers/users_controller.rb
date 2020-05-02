# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit]

  def new
    redirect_to user_path(current_user.id) if logged_in?
    @user = User.new unless logged_in?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    redirect_to root_path if current_user != @user
  end

  def edit; end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
