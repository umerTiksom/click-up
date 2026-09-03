class HomeController < ApplicationController
  def index
    @projects = Current.user.projects
    @tasks = Task.joins(:project)
                 .where(projects: { user_id: Current.user.id })
    @total_projects = @projects.count
    @total_tasks = @tasks.count
    @completed_task = @tasks.where(status: "completed").count
    @pending_tasks = @tasks.where(status: "pending").count
    @in_progress_tasks = @tasks.where(status: "in-progress").count
  end
end