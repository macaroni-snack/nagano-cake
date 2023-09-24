class Public::OrdersController < ApplicationController
  def new
    @order = Order.new

  end

  def calculate_total_amount(cart_items)
    total_amount = 0
    cart_items.each do |cart_item|
      total_amount += cart_item.subtotal
    end
    total_amount
  end

  def confirm
    @order = Order.new(order_params)

    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
     cart_item.customer_id = current_customer.id
    end
    @total_amount = calculate_total_amount(@cart_items) # 合計金額の計算メソッドを呼び出す

    @payment_method = params[:order][:payment_method]
    @address_option = params[:order][:address_option]
      if @address_option == "own_address"
        @order.post_code = current_customer.post_code
        @order.address = current_customer.address
        @order.name = current_customer.family_name + current_customer.first_name
        @address="〒"+@order.post_code+@order.address+@order.name
      end
    # もし住所が選択された場合、適切な方法で@addressを取得する処理を追加する
    if @address_option == "existing_address"
     @address = Address.find(params[:order][:address_id]).address_display

    elsif @address_option == "new_address"
      @address = Address.new(address_params)
      @address.customer_id = current_customer.id
      @address.save
      @address = Address.find(@address.id).address_display

      # 保存に成功した場合の処理
    # @address=@order.post_code+@order.address+@order.name
      flash[:success] = "新しいお届け先が登録されました。"
    end
  end

  def complete
  end

  def create
        @order = Order.new(order_params)
        @order.shipping_fee= 800
        @order.customer_id = current_customer.id
        @order.save

 # ordered_itmemに保存
    current_customer.cart_items.each do |cart_item| #カート内商品を1つずつ取り出しループ
      @order_detail = OrderDetail.new #初期化宣言
      @order_detail.order_id = @order.id #order注文idを紐付けておく
      @order_detail.item_id = cart_item.item_id #カート内商品idを注文商品idに代入
      @order_detail.quantity = cart_item.amount #カート内商品の個数を注文商品の個数に代入
      @order_detail.price = @order.total_payment 
      @order_detail.save  #注文商品を保存
    end #ループ終わり

        current_customer.cart_items.destroy_all #カートの中身を削除
        redirect_to orders_complete_path
  end

  def index
    @genres = Genre.all
    @orders = current_customer.orders

  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  private

  def address_params
    params.permit(:post_code, :address, :name,:payment_method)
  end

  def order_params
    params.require(:order).permit(:post_code, :payment_method, :name, :address ,:customer_id,:total_payment,:status,:shipping_fee)
  end
end
