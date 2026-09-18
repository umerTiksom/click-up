class ProjectsController < ApplicationController
  def index

    @project = Project.left_joins_project(Current.user).order(created_at: :asc)
                      .search_project(params[:search])
                      .paginate(page: params[:page], per_page: 4)

  end
  def create
    @project = Current.user.projects.new(project_params)
    if @project.save
      ProjectCreatedJob.perform_later(@project)
      flash[:notice] = "Project created!"
      redirect_to projects_path, notice: "Project created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @project = Project.show_specific_project(Current.user, params[:id]).first!
    authorize @project
    @tasks = @project.tasks
  end
  def new
    @project = Current.user.projects.new
  end
  def edit
    @project = Project.find(params[:id])
    authorize @project
  end
  def update
    @project = Current.user.projects.find(params[:id])
    authorize @project
    if @project.update(project_params)
      redirect_to project_path(@project), notice: "Project updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @project = Project.find(params[:project_id])
    authorize @project
    @project.destroy

    redirect_to projects_path, notice: "Project deleted successfully."
  end
  private
  def project_params
    params.require(:project).permit(:name,:description,:project_log)
  end
end