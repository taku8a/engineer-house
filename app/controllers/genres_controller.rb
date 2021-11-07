class GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user!, only: [:edit, :update]

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).reverse_order
  end

  def show
    @genre = Genre.find(params[:id])
    @genre_posts = @genre.posts.page(params[:page]).reverse_order
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.owner_id = current_user.id
    if @genre.save
      redirect_to genres_path, notice: t("notice.add_name")
    else
      @genres = Genre.page(params[:page]).reverse_order
      render "index"
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to genres_path, notice: t("notice.edit_name")
    else
      render "edit"
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def ensure_correct_user!
    @genre = Genre.find(params[:id])
    unless @genre.owner_id == current_user.id
      redirect_to genre_path(@genre), alert: t("alert.owner_right")
    end
  end

end
