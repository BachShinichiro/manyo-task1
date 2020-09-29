class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired] == "true"
      @tasks = Task.all.order(limit: "DESC").page(params[:page]).per(10)
    elsif params[:sort_priority] == "true"
      puts '優先順位のそーと'
      @tasks = Task.all.order(priority: "DESC").page(params[:page]).per(10)
    else
      @tasks = Task.all.order(created_at: "DESC").page(params[:page]).per(10)
    end

    if params[:search].present?
      if params[:name].present? && params[:status].present?
        @tasks = Task.name_search(params[:name]).status_search(params[:status]).page(params[:page]).per(10)
      elsif params[:name].present?
        @tasks = Task.name_search(params[:name]).page(params[:page]).per(10)
      elsif params[:status].present?
        @tasks = Task.status_search(params[:status]).page(params[:page]).per(10)
      else
        @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(10)
      end
    end
  end


  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :limit, :status, :priority)
  end
end
