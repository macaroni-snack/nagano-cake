class Public::GenresController < ApplicationController
  def show
  #   @genres = Genre.all
  #   @genres = Genre.where(is_enabled: true)
  
  # ビュー（ジャンル検索）から、送られてきたgenre_idを @genre_idに代入
    @genre_id = params[:genre_id]
  # ビュー（ジャンル検索）から送られてきたgenre_idを持つ Itemを全て取得
    @items = Item.where(genre_id: @genre_id)
    
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end
end
