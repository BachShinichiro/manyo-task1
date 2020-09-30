class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :new, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end

  def update
    if params[:back]
      render :edit
    else
      if @user.update(user_params)
        redirect_to user_path(@user.id), notice: '編集しました'
      else
        render :edit
      end
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :id, :user_id,:password_confirmation)
  end
  def check_user
    redirect_to tasks_path unless current_user.id == @user.id
  end
end
