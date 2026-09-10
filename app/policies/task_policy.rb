class TaskPolicy < ApplicationPolicy
  def show?
    user_can_access_task?
  end

  def create?
    record.project.user_id == user.id
  end
  def edit?
    user_can_access_task?
  end
  def update?
    user_can_access_task?
  end
  def destroy?
    admin?
  end
  def assigned_user?
    record.assign_to_id == user.id
  end
  def admin?
    record.project.user_id == user.id
  end
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:project).where(
        "projects.user_id = :user_id OR tasks.assign_to_id = :user_id",
        user_id: user.id
      ).distinct
    end
  end
  private
  def user_can_access_task?
    admin?||assigned_user?
  end
end
