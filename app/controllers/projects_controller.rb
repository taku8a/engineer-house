class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user!, only: [:edit, :update, :destroy]
  before_action :group_join!, only: [:join]

  def index
    @projects = Project.page(params[:page]).reverse_order
  end

  def show
    @project = Project.find(params[:id])
  end

  def join
    @project.users << current_user
    redirect_to  project_path(@project), notice: t("notice.join_member")
  end

  def leave
   @project = Project.find(params[:project_id])
   if @project.owner_id == current_user.id
     redirect_to project_path(@project), alert: t("alert.owner_leave")
   else @project.users.delete(current_user)
        redirect_to projects_path, notice: t("notice.leave_member")
   end
  end

  def edit
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.owner_id = current_user.id
    @project.users << current_user
    if @project.save
      redirect_to project_path(@project), notice: t("notice.add_name")
    else
      render "new"
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: t("notice.edit_name")
    else
      render "edit"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: t("notice.destroy_name")
  end
  
  def search
    @content = params[:content]
    @projects = Project.where('name LIKE ?', '%'+@content+'%').page(params[:page]).reverse_order
  end

  private

  def project_params
    params.require(:project).permit(:name, :introduction, :project_image)
  end

  def ensure_correct_user!
    @project = Project.find(params[:id])
    unless @project.owner_id == current_user.id
      redirect_to project_path(@project), alert: t("alert.owner_right")
    end
  end

  def group_join!
    @project = Project.find(params[:project_id])
    if @project.users.count >= 4 || @project.users.include?(current_user)
      redirect_to project_path(@project), alert: t("alert.project_end")
    end
  end
end