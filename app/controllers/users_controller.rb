class UsersController < ApplicationController
  before_action :current_user
  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
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
    @user = User.find(params[:id])
    redirect_to tasks_path unless current_user.id == @user.id
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :id, :user_id,:password_confirmation)
  end
end
