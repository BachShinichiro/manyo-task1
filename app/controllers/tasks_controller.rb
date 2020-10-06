class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user, only:[:index]

  def index
    if params[:sort_expired] == "true"
      @tasks = current_user.tasks.all.order(limit: "ASC").page(params[:page]).per(10)
    elsif params[:sort_priority] == "true"
      @tasks = current_user.tasks.order(priority: "ASC").page(params[:page]).per(10)
    else
      @tasks = current_user.tasks.order(created_at: "DESC").page(params[:page]).per(10)
    end

    if params[:search].present?
      if params[:name].present? && params[:status].present?
        @tasks = current_user.tasks.name_search(params[:name]).status_search(params[:status]).page(params[:page]).per(10)
      elsif params[:name].present?
        @tasks = current_user.tasks.name_search(params[:name]).page(params[:page]).per(10)
      elsif params[:status].present?
        @tasks = current_user.tasks.status_search(params[:status]).page(params[:page]).per(10)
      else
        @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
      end
    end
    @tasks = @tasks.page(params[:page]).per(10)
  end


  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "ブログを作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "ブログを消去しました！"
  end

  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :limit, :status, :priority)
  end
end
