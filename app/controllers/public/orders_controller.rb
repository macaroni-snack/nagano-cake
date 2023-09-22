class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    
  end
  
  def confirm
    @order = Order.new(order_params)
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
  end

  def index
    @orders = Order.all
  end

  def show
    
  end
  
  private
  
  def address_params
    params.permit(:post_code, :address, :name,:payment_method)
  end
  
  def order_params
    params.require(:order).permit(:post_code, :payment_method, :name, :saddress ,:member_id,:total_payment,:status,:address_option)
  end
end
