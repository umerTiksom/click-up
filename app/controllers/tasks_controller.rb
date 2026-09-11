class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_project_owner, only: [:new, :create]
  def index
    @task = @project.tasks

    if params[:priority].present?
      @task= @task.where(priority: params[:priority])
    end

    if params[:status].present?
      @task = @task.where(status: params[:status])
    end
  end
  def new
    @task = @project.tasks.new
    @users=User.all
  end
  def create
    @project = Project.find(params[:project_id])

    @task = @project.tasks.new
    authorize @task, :create?

    @task.assign_attributes(task_params)
    if @task.save
      redirect_to project_path(@project),
                  notice: "Task created successfully."
    else
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end
  def show
    authorize @task
  end

  def edit
    authorize @task
    @users=User.all
  end

  def update
    authorize @task
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: "Task updated successfully."
    else
      @users = User.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to project_tasks_path(@project),
                notice: "Task deleted successfully."
  end

  private
  def task_params
    if TaskPolicy.new(Current.user, @task).admin?
      params.require(:task).permit(
        :tittle,
        :description,
        :priority,
        :status,
        :assign_to_id
      )
    else
      params.require(:task).permit(:status)
    end
  end
  def set_project
    @project = Project.find(params[:project_id])

  end
  def set_task
    @task = @project.tasks.find(params[:id])
  end
  def check_project_owner
    unless @project.user == Current.user
      redirect_to project_path(@project),
                  alert: "You are not authorized to create tasks."
    end
  end
end
