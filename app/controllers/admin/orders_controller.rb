class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def new
    @order = Order.new
    @addresses = current_member.addresses.all
  end
  
  def index
    @orders = Order.all 
  end
  
  def confirm   # 注文情報入力確認画面
  end
  
  
  def show
  @order = Order.find(params[:id])
  @customer = @order.customer
  @orders = @customer.orders
  
  
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
    @order = Order.find(params[:id])
  if @order.update(order_params)
    if @order.status == "入金確認" # ①
      @order.order_details.update_all(making_status: :製作待ち) # ①
    end
    redirect_to admin_order_path(@order)
  end
  end

  private
    def order_params
        params.require(:order).permit(:post_code, :payment_method, :name, :saddress ,:member_id,:total_payment,:status)
    end
end

