class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @projects = Project.page(params[:page]).reverse_order
  end

  def show
    @project = Project.find(params[:id])
  end

  def join
    @project = Project.find(params[:project_id])
    @project.users << current_user
    redirect_to  projects_path
  end

  def leave
   @project = Project.find(params[:project_id])
   @project.users.delete(current_user)
   redirect_to projects_path
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
      redirect_to projects_path
    else
      render "new"
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path
    else
      render "edit"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def project_params
    params.require(:project).permit(:name, :introduction, :project_image)
  end

  def ensure_correct_user
    @project = Project.find(params[:id])
    unless @project.owner_id == current_user.id
      projects_path
    end
  end
end