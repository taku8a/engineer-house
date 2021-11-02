class GenreDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_genre_detail!
  
  def index
    @genre_details = GenreDetail.all
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
      redirect_to genre_details_path
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
      redirect_to genre_details_path
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
