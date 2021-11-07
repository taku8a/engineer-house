class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @projects = current_user.projects.page(params[:page]).reverse_order
    @posts = current_user.posts.page(params[:page]).reverse_order
    @my_project = []
    @projects.each do |project|
      if project.owner_id == current_user.id
        @my_project << project
      end
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to mypage_users_path, notice: t("notice.mypage")
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_user.update_attribute(:is_valid, false)
    reset_session
    redirect_to root_path, notice: t("notice.leave_user")
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image_id, :introduction)
  end

end
