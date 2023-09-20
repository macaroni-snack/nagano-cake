class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end
  
  def update
  end
  
  def destroy
  end
  
  def destroy_all
  end
  
  def create
  end
end
