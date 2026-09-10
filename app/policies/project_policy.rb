class ProjectPolicy < ApplicationPolicy
  def show?
    user_can_access_project?
  end

  def edit?
    owner?
  end
  def update?
    owner?
  end
  private
  def owner?
    record.user_id == user.id
  end
  def user_can_access_project?
    owner?||record.tasks.exists?(assign_to_id: user.id)
  end
end
