class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired] == "true"
      @tasks = Task.all.order(limit: "DESC")
    # elsif params[:search][:title].present?
    #   @tasks = Task.where('title like ?',"%#{params[:search][:title]}%")#ここであいまい検索のパラメーターを受け取る
    else
      @tasks = Task.all.order(created_at: "DESC")
      # @tasks.where('title like ?','%params[:search]%') if params[:search][:title].present?
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
    params.require(:task).permit(:name, :content, :limit)
  end
end
