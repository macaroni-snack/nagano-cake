
# 小数点以下の誤差がでないようにする
require 'bigdecimal'

class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total_amount = calculate_total_amount(@cart_items) # 合計金額の計算メソッドを呼び出す
  end

  def create
    @cart_item_check = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
    
    if @cart_item_check
      @cart_item_check.amount += params[:cart_item][:amount].to_i
      @cart_item_check.save
      flash[:success] = "カートに存在済のアイテムです"
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:success] = "カートに追加しました"
        redirect_to cart_items_path
      else
        flash[:danger] = "予期せぬエラーが発生しました"
        redirect_back(fallback_location: root_path)
      end
    end
    
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:success] = "個数を変更しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "正しい個数を入力してください"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:success] = "選択いただいたカートを空にしました"
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all
    flash[:success] = "カートの中を空にしました"
    redirect_back(fallback_location: root_path)
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def calculate_total_amount(cart_items)
    total_amount = BigDecimal('0') # BigDecimalを初期化

    cart_items.each do |cart_item|
      item_price = BigDecimal(cart_item.item.price.to_s) # 商品価格をBigDecimalに変換
      total_amount += item_price * BigDecimal('1.1') * BigDecimal(cart_item.amount.to_s)
    end

    total_amount = total_amount.to_i # 小数点以下を切り捨てて整数に変換
    total_amount.to_s # 整数として合計金額を文字列として返す
  end
end
