class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品の新規登録が完了しました。"
      redirect_to admin_items_path(@items)
    else
      flash[:notice] = "商品の新規登録内容に不備があります。"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Itam.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品詳細の変更が完了しました。"
      redirect_to admin_items_path(@items)
    else
      flash[:notice] = "商品詳細の変更内容に不備があります。"
      render :edit
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active)
  end
end
