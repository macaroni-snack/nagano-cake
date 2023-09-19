class Public::CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end
  
  def show
    @costomer = current_costomer
  end


  def edit
  end
  
  def update
  end

  def confirm_withdrawal
  end
  
  def withdrawal
  end
end
