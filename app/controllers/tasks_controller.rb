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
    @task = @project.tasks.new(task_params)

    if @task.save
      redirect_to project_path(@project),
                  notice: "Task created successfully."
    else
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end
  def show
    @task = @project.tasks.find(params[:id])
  end

  def edit
    @users=User.all
  end

  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: "Task updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to project_path(@project),
                notice: "Task deleted successfully."
  end

  private
  def task_params
    params.require(:task).permit(
      :tittle,
      :description,
      :priority,
      :status,
      :assign_to_id
    )
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
