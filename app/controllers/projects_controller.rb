class ProjectsController < ApplicationController
  def index
    @project = Current.user.projects
  end
  def create
    @project = Current.user.projects.new(project_params)
    if @project.save
      redirect_to home_path, notice: "Project created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @project = Current.user.projects.find(params[:id])
  end
  def new
    @project = Current.user.projects.new
  end
  def edit
    @project = Current.user.projects.find(params[:id])
  end

  def update
    @project = Current.user.projects.find(params[:id])

    if @project.update(project_params)
      redirect_to project_path(@project), notice: "Project updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @project = Current.user.projects.find(params[:id])
    @project.destroy

    redirect_to projects_path, notice: "Project deleted successfully."
  end
  private
  def project_params
    params.require(:project).permit(:name,:description)
  end
end