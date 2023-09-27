class Public::CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def show
    @customer = current_customer
  end


  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to '/customers/my_page'
  end

  def confirm_withdrawal
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :telephone_number, :post_code, :address)
  end

end
