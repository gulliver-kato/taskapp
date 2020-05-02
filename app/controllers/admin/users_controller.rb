# frozen_string_literal: true

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
    @user.save
    redirect_to(admin_users_path)
  end

  def show; end

  def edit; end

  def update
    @user.update(user_params)
    redirect_to(admin_users_path)
  end

  def destroy
    @user.destroy
    redirect_to(admin_users_path)
  end

  private

  def check_admin
    redirect_to(root_path) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
