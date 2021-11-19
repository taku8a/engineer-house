class ProjectChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_chat!

  def index
    @project_chat = ProjectChat.new
    @project_chats = @project.project_chats
  end

  def create
    @project_chats = @project.project_chats
    @project_chat = current_user.project_chats.new(project_chat_params)
    if @project_chat.save
      flash.now[:notice] = t("notice.send_chat")
      render "create"
    else
      render "error"
    end
  end

  private

  def project_chat_params
    params.require(:project_chat).permit(:chat, :project_id, :user_id)
  end

  def correct_chat!
    @project = Project.find(params[:project_id])
    unless @project.assigned?(current_user)
      redirect_to project_path(@project), alert: t("alert.not_chat")
    end
  end
end