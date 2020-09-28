class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired] == "true"
      @tasks = Task.all.order(limit: "DESC")
    elsif params[:sort_priority] == "true"
      @tasks = Task.all.order(priority: "ASC")
    else
      @tasks = Task.all.order(created_at: "DESC")
    end

    if params[:search].present?
      if params[:name].present? && params[:status].present?
        @tasks = Task.name_search(params[:name]).status_search(params[:status])
      elsif params[:name].present?
        @tasks = Task.name_search(params[:name])
      elsif params[:status].present?
        @tasks = Task.status_search(params[:status])
      else
        @tasks = Task.all.order(created_at: :desc)
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
