class PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_comment!, except: [:select, :seek]
  before_action :ensure_correct_user!, only: [:edit, :update, :destroy]

  def index
    @post_comments = @post.post_comments.page(params[:page]).reverse_order
  end

  def search
    @content = params[:content]
    @post_comments = @post.post_comments.where('comment LIKE ?', '%'+@content+'%').page(params[:page]).reverse_order
  end

  def select
    @post_comments = PostComment.page(params[:page]).reverse_order
  end

  def seek
    @content = params[:content]
    @post_comments = PostComment.where('comment LIKE ?', '%'+@content+'%').page(params[:page]).reverse_order
  end

  def show
    @post_comment = PostComment.find(params[:id])
  end

  def new
    @post_comment = PostComment.new
    @genre_details = GenreDetail.page(params[:genre_detail_page]).reverse_order
  end

  def create
    @post_comment =PostComment.new(post_comment_params)
    if @post_comment.save
      redirect_to post_post_comment_path(@post_comment.post_id, @post_comment.id), notice: t("notice.post_create")
    else
      render "new"
    end
  end

  def edit
    @genre_details = GenreDetail.page(params[:genre_detail_page]).reverse_order
  end

  def update
    if @post_comment.update(post_comment_params)
      redirect_to post_post_comment_path(@post_comment.post_id, @post_comment.id), notice: t("notice.post_update")
    else
      render "edit"
    end
  end

  def destroy
    @post_comment.destroy
    redirect_to post_post_comments_path(@post), notice: t("notice.post_destroy")
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :user_id, :post_id, genre_detail_ids: [])
  end

  def set_post_comment!
    @post = Post.find(params[:post_id])
  end

  def ensure_correct_user!
    @post_comment = PostComment.find(params[:id])
    unless current_user.my_post_comment?(@post_comment)
      redirect_to post_post_comment_path(@post.id, @post_comment.id), alert: t("alert.owner_right")
    end
  end

end
