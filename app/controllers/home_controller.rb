class HomeController < ApplicationController
  def index
    @projects = Project .joins(:tasks) .where("projects.user_id = :user_id OR tasks.assign_to_id = :user_id", user_id: Current.user.id ) .distinct
    @tasks = Task .joins(:project) .where("projects.user_id = :user_id OR tasks.assign_to_id = :user_id", user_id: Current.user.id ) .distinct
    @total_projects = @projects.count
    @total_tasks = @tasks.count
    @completed_task = @tasks.where(status: "completed").count
    @pending_tasks = @tasks.where(status: "pending").count
    @in_progress_tasks = @tasks.where(status: "in-progress").count
  end
end