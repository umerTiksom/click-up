class ProjectCreatedJob < ApplicationJob
  queue_as :default

  def perform(project)
    if project.save
      user = project.user
      puts "Project #{project.name} created successfully"
      puts "Project is created by #{user.name}"

    end
  end
end
