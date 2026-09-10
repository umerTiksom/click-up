class ProjectsController < ApplicationController
  def index
    @project = Project
                 .left_joins(:tasks)
                 .where(
                   "projects.user_id = :user_id OR tasks.assign_to_id = :user_id",
                   user_id: Current.user.id
                 )
                 .distinct

    if params[:search].present?
      @project = @project.where("projects.name ILIKE ?", "#{params[:search]}%")
    end
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
    @project = Project
                 .left_joins(:tasks)
                 .where(
                   "projects.id = :project_id AND
       (projects.user_id = :user_id OR tasks.assign_to_id = :user_id)",
                   project_id: params[:id],
                   user_id: Current.user.id
                 )
                 .distinct
                 .first!
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
  def toggle_active
    @project = Project.find(params[:id])
    authorize @project, :update?

    @project.update(active: !@project.active?)

    redirect_to projects_path
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
    @project = Project.find(params[:id])
    authorize @project
    @project.destroy

    redirect_to projects_path, notice: "Project deleted successfully."
  end
  private
  def project_params
    params.require(:project).permit(:name,:description)
  end
end