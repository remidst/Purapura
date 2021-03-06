class DocumentsController < ApplicationController
  def create
      project = Project.find(params[:project_id])
      document = project.documents.create(document_params)
      document.set_publisher!(current_user)

      project_users = project.users.where.not(id: current_user.id)

      redirect_to project_path(project, to: 'documents'), notice: "ファイルが案件のメンバーに共有されました。"
  end

  def edit
    authorize @document
  end

  def destroy
    document = Document.find(params[:id])
    project = Project.find(params[:project_id])
    authorize document

    document.destroy
    respond_to do |format|
      format.html { redirect_to project_path(project, to: 'documents'), notice: 'ファイルが削除されました。' }
      format.json { head :no_content }
    end
  end

  private

  def notification_document_exists?(user, project)
    user.notifications.where(read: false, project_id: project.id, content: "新しいファイルが共有されました。").present?
  end

  def document_params
  	params.require(:document).permit(:attachment, :category, :name, :user_ids => [])
  end

end
