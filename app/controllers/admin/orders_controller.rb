class Admin::OrdersController < ApplicationController
  before_action :authenticate_member!
  def new
    @order = Order.new
    @addresses = current_member.addresses.all
  end
  
  def index
    @orders = Order.all 
  end
  
  def confirm   # 注文情報入力確認画面
        @order = Order.new(order_params)

    #  [:address_option]=="0"のデータ(memberの住所)を呼び出す
        if params[:order][:address_option] == "0"
        @order.shipping_post_code = current_customer.post_code
        @order.shipping_address = current_customer.address
        @order.shipping_name = current_customer.family_name + current_customer.first_name 
        end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      # 注文が正常に保存された場合の処理
      redirect_to root_path, notice: 'Order was successfully placed.'
    else
      # 保存に失敗した場合の処理
      render :new
    end
  end

  def update
  end
  
  private
    def order_params
        params.require(:order).permit(:post_code, :payment_method, :name, :saddress ,:member_id,:total_payment,:status)
    end

  end
end
