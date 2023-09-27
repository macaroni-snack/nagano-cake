class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @genres = Genre.all
    @genre_id = params[:genre_id]
  end

  def about
  end
end
