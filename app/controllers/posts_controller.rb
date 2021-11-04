class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: t("notice.post_create")
    else
      render "new"
    end
  end

  def update
   if @post.update(post_params)
     redirect_to posts_path, notice: t("notice.post_update")
   else
     render "edit"
   end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: t("notice.post_destroy")
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, genre_ids: [], genre_detail_ids: [])
  end

  def ensure_correct_user!
    @post = Post.find(params[:id])
    unless @post.user_id = current_user.id
      posts_path
    end
  end

end
