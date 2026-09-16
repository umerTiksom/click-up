class TaskMailer < ApplicationMailer
  def task_assigned
    @task = params[:task]
    @user = @task.assign_to
    mail(
    to: @user.email_address,
    subject: "New task assigned #{@task.tittle}"
    )
  end
end
