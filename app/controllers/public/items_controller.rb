class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @genres = Genre.all
    @orders = params[:genre_id].present? ? Genre.find(params[:genre_id]).orders : Order.all
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