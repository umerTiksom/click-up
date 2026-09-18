class ProjectFilesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    authorize @project, :show?
    files = params[:files]
    if files.present?
      files.each do|data|
        @project.files.attach(data)
      end
      redirect_to project_path(@project), notice: "Files upload successfully"
    else
      redirect_to project_path(@project), alert: "Please attach atleast one file to upload"
    end
  end
  def download
    @project = Project.find(params[:project_id])
    file = @project.files.attachments.find(params[:id])
    redirect_to rails_blob_path(file,disposition: 'attachment')
  end
  def destroy
    @project = Project.find(params[:project_id])
    authorize @project, :update?
    file = @project.files.attachments.find(params[:id])
    file.purge
    redirect_to project_path(@project), notice: "File deleted successfully"
  end
end
