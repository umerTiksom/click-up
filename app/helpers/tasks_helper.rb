module TasksHelper
  def task_status_badge(task)
     if task.status == "completed"
       content_tag(:span, "Completed",class: "badge bg-success text-white")
     elsif task.status == "in-progress"
       content_tag(:span,"In Progress",class: "badge bg-warning text-dark")
     elsif task.status == "pending"
       content_tag(:span,"Pending",class: "badge bg-secondary ")
     end
  end
  def task_priority_badge(task)
    if task.priority == "high"
      content_tag(:span,"High",class: "badge bg-danger text-white")
    elsif task.priority == "medium"
      content_tag(:span,"Medium",class: "badge bg-warning text-dark")
    elsif task.priority == "low"
      content_tag(:span,"Low",class: "badge bg-success text-white")
    end
  end
end