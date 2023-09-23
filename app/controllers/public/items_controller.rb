class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @genre_id = params[:genre_id]

    if @genre_id != nil
      @items = Genre.find(@genre_id).items
      @index = Genre.find(params[:genre_id]).name

    else
      @items = Item.all
      @index = '商品'
    end

  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    # @genres = Genre.where
  end

private
  def item_params
    params.require(:items).permit(:image,:genre_id,:name,:introduction,:image_id,:price)
  end

end