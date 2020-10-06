class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update,:destroy]
  before_action :current_user
  before_action :current_user_admin, only: [:show, :edit, :update, :index, :new, :create]

  def index
    @users = User.all.includes(:tasks).order(id: :ASC).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    if params[:back]
      render :edit
    else
      if @user.update(user_params)
        redirect_to admin_users_path, notice: '編集しました'
      else
        render :edit
      end
    end
  end

  def show
    @tasks = @user.tasks.page(params[:page]).per(10)
  end

  def edit
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: '削除しました'
    else
      redirect_to admin_users_path
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def current_user_admin
    # unless current_user.nil?
    #   redirect_to tasks_path
    # end
    unless current_user.admin
      flash[:notice] = '管理者以外はアクセスできません'
      redirect_to tasks_path
    end
  end
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation,)
  end
end
