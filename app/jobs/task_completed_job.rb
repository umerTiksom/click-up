class TaskCompletedJob < ApplicationJob
  queue_as :default

  def perform(task)
    user = task.assign_to
    return unless user
    puts "Notification send to #{user.name}"
    puts "Task #{task.tittle} is completed"
  end
end
