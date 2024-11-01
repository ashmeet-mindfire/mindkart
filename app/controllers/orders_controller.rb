class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
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
      redirect_to orders_path, notice: "Order placed successfully!"
    else
      redirect_to cart_path, notice: "Failed to place order"
    end
  end

  # def update
  #   @order = Order.find(params[:id])
  #   if @order.update(update_order_params)
  #     redirect_to dashboard_index_path, notice: "Order status updated successfully"
  #   else
  #     redirect_to dashboard_index_path, notice: "Something went wrong"
  #   end
  # end
  private

  def order_params
    params.require(:order).permit(:user_id)
  end

  def update_order_params
    params.require(:order).permit(:status)
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
