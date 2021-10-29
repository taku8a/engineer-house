class ProjectChatsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @project = Project.find(params[:project_id])
    @project_chat = ProjectChat.new
    @project_chats = @project.project_chats
  end

  def create
    @project = Project.find(params[:project_id])
    @project_chat = current_user.project_chats.new(project_chat_params)
    if @project_chat.save
      redirect_to project_project_chats_path(@project)
    else
      @project = Project.find(params[:project_id])
      @project_chats = @project.project_chats
      render "index"
    end
  end

  private

  def project_chat_params
    params.require(:project_chat).permit(:chat, :project_id, :user_id)
  end
end
