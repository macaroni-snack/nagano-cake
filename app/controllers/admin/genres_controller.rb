class Admin::GenresController < ApplicationController

  def index
    #投稿
    @genre = Genre.new
    #一覧
    @genres = Genre.all

  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to '/admin/genres'
  end


  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    redirect_to '/customers/my_page'
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
