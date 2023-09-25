class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all

  if params[:search_name].present?
    @orders = @orders.where(name: params[:search_name])
  end
    

  end
end
