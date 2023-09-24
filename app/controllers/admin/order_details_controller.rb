class Admin::OrderDetailsController < ApplicationController

 def update
 @order_detail = OrderDetail.find(params[:id])
 
  if @order_detail.update(order_detail_params)
    if @order_detail.making_status == "製作完了"
      @order = @order_detail.order
      @order.update(status: :発送準備中) if @order.order_details.all? { |detail| detail.making_status == "製作完了" }
    elsif @order_detail.making_status == "製作中"
      @order = @order_detail.order
      @order.update(status: :製作中)
    end
    redirect_to admin_order_path(@order_detail.order)
  end
 end
 
 
 
private
 def order_detail_params
    params.require(:order_detail).permit(:making_status)
 end

 # def order_params
 #    params.require(:order).permit(:status)
 # end
end
