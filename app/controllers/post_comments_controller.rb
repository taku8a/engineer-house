class PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_comment!
  
  def index
    @post_comments = PostComment.all
  end
  
  def show
    @post_comment = PostComment.find(params[:id])
  end
  
  def new
    @post_comment = PostComment.new
  end
  
  def create
    @post_comment =PostComment.new(post_comment_params)
    if @post_comment.save
      redirect_to post_post_comments_path(@post)
    else
      render "new"
    end
  end
  
  def edit
    @post_comment = PostComment.find(params[:id])
  end
  
  def update
    @post_comment = PostComment.find(params[:id])
    if @post_comment.update(post_comment_params)
      redirect_to post_post_comments_path(@post)
    else
      render "edit"
    end
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to post_post_comments_path(@post)
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment, :user_id, :post_id, genre_detail_ids: [])
  end
  
  def set_post_comment!
    @post = Post.find(params[:post_id])
  end
  
end
