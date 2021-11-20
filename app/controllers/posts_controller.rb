class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user!, only: [:edit, :update, :destroy, :search_edit]
  before_action :set_collection!, only: [:new, :edit, :create, :update]

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
      redirect_to post_path(@post), notice: t("notice.post_create")
    else
      render "new"
    end
  end

  def update
   if @post.update(post_params)
     redirect_to post_path(@post), notice: t("notice.post_update")
   else
     render "edit"
   end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: t("notice.post_destroy")
  end

  def search
    @content = params[:content]
    @posts = Post.where('title LIKE ?', '%'+@content+'%').page(params[:page]).reverse_order
  end

  def search_new
    @post = Post.new
    @method = params[:search_method]
    case @method
      when "genre"
        @content = params[:content]
        @box = params[:box]
        @genres = Genre.where('name LIKE ?', '%'+@content+'%').page(params[:genre_page]).reverse_order
        @genre_details = GenreDetail.page(params[:genre_detail_page]).reverse_order
      when "genre_detail"
        @content = params[:content]
        @box = params[:box]
        @genres = Genre.page(params[:genre_page]).reverse_order
        @genre_details = GenreDetail.where('title LIKE ?', '%'+@box+'%').page(params[:genre_detail_page]).reverse_order
    end
  end
  
  def search_edit
    @method = params[:search_method]
    case @method
      when "genre"
        @content = params[:content]
        @box = params[:box]
        @genres = Genre.where('name LIKE ?', '%'+@content+'%').page(params[:genre_page]).reverse_order
        @genre_details = GenreDetail.page(params[:genre_detail_page]).reverse_order
      when "genre_detail"
        @content = params[:content]
        @box = params[:box]
        @genres = Genre.page(params[:genre_page]).reverse_order
        @genre_details = GenreDetail.where('title LIKE ?', '%'+@box+'%').page(params[:genre_detail_page]).reverse_order
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, genre_ids: [], genre_detail_ids: [])
  end

  def ensure_correct_user!
    @post = Post.find(params[:id])
    unless current_user.my_post?(@post)
      redirect_to post_path(@post), alert: t("alert.owner_right")
    end
  end
  
  def set_collection!
    @genres = Genre.page(params[:genre_page]).reverse_order
    @genre_details = GenreDetail.page(params[:genre_detail_page]).reverse_order
  end

end
