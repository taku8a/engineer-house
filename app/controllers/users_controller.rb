class UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @projects = current_user.projects.page(params[:project_page]).reverse_order
    @posts = current_user.posts.page(params[:post_page]).reverse_order
    @my_projects = []
    @projects.each do |project|
      if project.owner_id == current_user.id
        @my_projects << project
      end
    end
    @my_project = Kaminari.paginate_array(@my_projects).page(params[:my_project_page]).per(10)
    @post_comments = current_user.post_comments.page(params[:comment_page]).reverse_order
    @my_genres = []
    @genres = Genre.all
    @genres.each do |genre|
      if genre.owner_id == current_user.id
        @my_genres << genre
      end
    end
    @my_genre = Kaminari.paginate_array(@my_genres).page(params[:genre_page]).per(10)
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

  def index
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:post_page]).reverse_order
    @post_comments = @user.post_comments.page(params[:comment_page]).reverse_order
    @projects = @user.projects.page(params[:project_page]).reverse_order
  end

  def search
    @content = params[:content]
    @users = User.where('name LIKE ?', '%'+@content+'%').page(params[:page]).reverse_order
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image_id, :introduction)
  end

end
