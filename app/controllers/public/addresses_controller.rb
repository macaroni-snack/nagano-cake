class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id #会員IDがログインしているユーザーの場合に限定してる
    if @address.save
      flash[:notice] = "新しい配送先の登録が完了しました。"
      redirect_to addresses_path(@address)
    else
      @addresses = Address.all
      flash.now[:notice] = "新しい配送先の登録に失敗しました。"
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
  	if @address.update(address_params)
  	  flash[:notice] = "配送先の変更内容を保存しました。"
  	  redirect_to addresses_path
  	else
  	   flash.now[:notice] = "新しい配送先の変更に失敗しました。"
  	   render :edit
  	end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    if @address.destroy
      flash[:notice] = "配送先の削除が完了しました。"
      redirect_to addresses_path
    else
      flash.now[:notice] = "配送先の削除に失敗しました。"
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:post_code, :address, :name, :customer_id)
  end
end
