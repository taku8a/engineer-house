class UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @projects = current_user.projects.page(params[:project_page]).reverse_order
    @posts = current_user.posts.page(params[:post_page]).reverse_order
    @my_projects = []
    @project_all = Project.all
    current_user.owned_projects(@project_all,@my_projects)
    @my_project = Kaminari.paginate_array(@my_projects.sort.reverse).page(params[:my_project_page])
    @post_comments = current_user.post_comments.page(params[:comment_page]).reverse_order
    @my_genres = []
    @genres = Genre.all
    current_user.owned_genres(@genres,@my_genres)
    @my_genre = Kaminari.paginate_array(@my_genres.sort.reverse).page(params[:genre_page])
  end

  def edit
  end

  def update
    unless params[:user].present?
      flash[:alert] = t("alert.doubt")
      redirect_back(fallback_location: root_path)
      return
    end
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
    params.require(:user).permit(:name, :profile_image, :introduction, :email)
  end

end
