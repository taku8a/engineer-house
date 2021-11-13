class GenreDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_genre_detail!, except: [:select, :seek]

  def index
    @genre_details = @genre.genre_details.order(updated_at: :desc).page(params[:page])
  end

  def search
    @content = params[:content]
    @genre_details = @genre.genre_details.where('title LIKE ?', '%'+@content+'%').page(params[:page]).reverse_order
  end

  def select
    @genre_details = GenreDetail.page(params[:page]).reverse_order
  end

  def seek
    @content = params[:content]
    @genre_details = GenreDetail.where('title LIKE ?', '%'+@content+'%').page(params[:page]).reverse_order
  end

  def new
    @genre_detail = GenreDetail.new
  end

  def show
    @genre_detail = GenreDetail.find(params[:id])
  end

  def create
    @genre_detail = GenreDetail.new(genre_detail_params)
    if @genre_detail.save
      redirect_to genre_genre_detail_path(@genre_detail.genre_id, @genre_detail.id), notice: t("notice.post_create")
    else
      render "new"
    end
  end

  def edit
    @genre_detail = GenreDetail.find(params[:id])
  end

  def update
    @genre_detail = GenreDetail.find(params[:id])
    if @genre_detail.update(genre_detail_params)
      redirect_to genre_genre_detail_path(@genre_detail.genre_id, @genre_detail.id), notice: t("notice.post_update")
    else
      render "edit"
    end
  end

  private

  def genre_detail_params
    params.require(:genre_detail).permit(:title, :body, :genre_id)
  end

  def set_genre_detail!
    @genre = Genre.find(params[:genre_id])
  end

end
