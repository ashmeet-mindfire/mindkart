class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @orders = current_user.orders
  end

  def details
    @order = current_user.orders.find(params[:id])
    @order_items = @order.order_items
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = "pending"

    if @order.save
      create_order_items
      @order.calculate_total
      @order.save
      current_user.cart.destroy
      redirect_to order_list_path, notice: "Order placed successfully!"
    else
      redirect_to cart_path, notice: "Failed to place order"
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id)
  end

  def create_order_items
    cart_items = current_user.cart.cart_items
    cart_items.each do |item|
      @order.order_items.create(
        book_id: item.book.id,
        quantity: item.quantity,
        price: item.book.price * item.quantity
      )
    end
  end
end
