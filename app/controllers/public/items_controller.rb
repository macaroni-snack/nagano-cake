class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @genres = Genre.all
    @genre_id = params[:genre_id]
  # @orders = params[:genre_id].present? ? Genre.find(params[:genre_id]).orders : Order.all
    if @genre_id != nil
     p 'test1'
    else
     @items = Item.all
    end
    # @orders = params[:genre_id].present? ? Genre.find(params[:genre_id]).orders : Order.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    # @genres = Genre.where
  end

private
  def item_params
    params.require(:items).permit(:genre_id,:name,:introduction,:image_id,:price)
  end
  
end